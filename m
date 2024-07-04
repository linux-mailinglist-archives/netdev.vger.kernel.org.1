Return-Path: <netdev+bounces-109228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79192779E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E21282BA0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A15191F70;
	Thu,  4 Jul 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ibJD+rqz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E992F37;
	Thu,  4 Jul 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101683; cv=fail; b=M0yc7tNeeBVQtnH4QlTLEsVasGjoePro8rRnviMbWvti1n6sGjMD8h2IFtfOTaX1kq0t8za/vkUp7tDUsCtfxYRjkCULhxjrxBDpXsU87qORYX+tsO9hwz56ULIH4cybc0Ko5bqv5ISxdB9TBZlgOsGlwIWlXd/60rOaM0tHo8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101683; c=relaxed/simple;
	bh=FQTgxI5o4N67O2+/P9UrqHR3kg1I9hBO4UPVA/NHZIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/DtPeAiR0gHTQaX2Z4qWK9Op6naMIME2XQu5CF0Db/SiQkHTjqpGAu434QDsXf6pSVoGGULmeHCE8BO2lN/MYfVzqVxweuEFOnyHo+82mX7hEdYto2QjK4bGiswcNjJ6VcldfONlWm7gpZ4/CCjuCGxUAEwU9fZkh7YxF7MFdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ibJD+rqz; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN5jK47wrSptZsaXQ/+PcYW9U5K1Kt/zwtGC1XIg4llfo0raHET2rKmlg3t4WfAKFmDlBs0qa9W2H5u/YOLnzM7RaIhOl0+gqbF1167VhZ9g9sr5NxusxXy8zqg7Zb2S9jgLzrVrUPESXeUMcPbxQdniWw461mQFtGhUXBfpoenykYZbd9kSdxw5R1K6Wnn7pJX6RbDxm3ojU7m58D29TqvqB3okKrnRMQXmXPnfLqWLrDltFMvqwcWMfjUqzikKzX4rGqL+VaYwXSGGvT0xNAw73XKz+1tpOKzN69RgA59c02R8lFBHtOv0m4FaBFsM3SZSCFYmxZ1mvfV/HpasSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB0H3nwPIC5VbI2MlxF44lXflZ/IGsWNk+xc++yQUhI=;
 b=jZXbSrdFUDhmYrJHeMbayPIAOdOUMHPqcGn1a1FdzBC5rEq4v0iqX1DvvdOWm1iwIGA5hof+PTsRUVocOUFoul3F/SlXsMcts2aBzwLr+5Gsr+CM90FjlqZXaKXIzc332x2BFUlRPKCHgBCvi98R84n99M/irorJZXIg2R5BdQ8qv7beWL6hqbDCot+s6WGwg6xf7XWy0DYGxvlzaWl0wblW51x+3WCiIMcYX4ua15jPfjyErTG4JB9O/KAwjSTwxn7TPO/cW5vaA4WavRqFvHhXTIjgcF25bJ6iEcxu60Ut2m1079OIQOxlTg1Uv2sfB3oKJ+PqhCPD6SdvdPhJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB0H3nwPIC5VbI2MlxF44lXflZ/IGsWNk+xc++yQUhI=;
 b=ibJD+rqzzpPp5KuIH4wPx6ljizKH/XYhkeSyA3i6VstMriJ1dHC4Yh1+t6jRyEPXbAV83HkfERslBpvsetjE9TEMdmImJgpJ+9pBiLKOcC3mfkYzLB9yVVuACJxtQb4ZLA6dzDC9MnMecp1FW4suPR8LAQbXRmAYhUJaIMHo2Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DU0PR02MB10014.eurprd02.prod.outlook.com (2603:10a6:10:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 14:01:16 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 14:01:16 +0000
Message-ID: <26dcc3ee-6ea8-435e-b9e9-f22c712e5b4c@axis.com>
Date: Thu, 4 Jul 2024 16:01:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link
 modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-5-kamilh@axis.com>
 <5a77ba27-1a0e-4f29-bf94-04effb37eefb@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <5a77ba27-1a0e-4f29-bf94-04effb37eefb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DU0PR02MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: c809b15e-3bf8-47f4-b339-08dc9c31c56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWhobmdoRVlEMWROeGY0MGhtdXQvSVY0bmpvanIwanF6ZnhMM1YxWml0Vnpu?=
 =?utf-8?B?UW4vZk5zbUVMVEFwZU1pSUxrVkFwM3I0QUJtY2s0dGFHSkw5aU5wNzVqcm05?=
 =?utf-8?B?cHo5ZzR6MXRWMzVHTHg2WUt1THJUdmg5QmVwdFVzajUwUVhJYnZpS0psMUs5?=
 =?utf-8?B?MUlIRkFqcU43K2owc2xoYWJBYm1URUdBUS9YOGRvZjJITXVUYitsdUhSWVdS?=
 =?utf-8?B?ZUhOcVdDZVdZZ3JCWlVRUm44ZDcyVExzREZsYmVYNWdQcUlQNnBHODRaMzU5?=
 =?utf-8?B?bis4WFV3OVhvcExjZ1pLd1FJdTJZZ2IrWU5aWUVkWGhVR01YSk5GdmJXTUpY?=
 =?utf-8?B?VU9RMHJiejlkNitKVm9IaVEwOTVXY1FyYVZKaEFkUldYU3R1NnlWS094STlh?=
 =?utf-8?B?NGNUaU1udGdBck51d3dCWlV6UlM0bGhKVTVTbE1YOFYrc3hZZGo5WmxwVU1v?=
 =?utf-8?B?T0VXVEY5dkxwR2JYWGUwSjlVRnZyeG1BMHNRNlpaQk9nQjBlNlFsbVpXRGo4?=
 =?utf-8?B?cEJSTG44WktTMU50Vm9zSEtWbzQ5ZVNSaHB3Z1VZRTBSNXZ4bTczSTNFeE5P?=
 =?utf-8?B?WENZRWo1ZmtURFFPeFVHUEJzaVcwaEdLNXZNeHZ4V2YvMWdwcUVaQjc1RGJG?=
 =?utf-8?B?NnhpSDZuTHlTQ25TSE9QWWlKMS9NcUVqeHBJZ3c0WWVBTmlySXNIcDQybFFp?=
 =?utf-8?B?Q29zN1ZuVkt3TnIwRkFJdUFGWFRnUysvSjR0SzVDTkJRMHgxdlV6dnJpMTd0?=
 =?utf-8?B?Ry9rYW9DOCtNOUVud1lCVDdid0xLeEgyWE5yTTNHTUN2ZUJNc3Q3c0s3MVNN?=
 =?utf-8?B?UVBvY25rdDgwajUwVXFDdEVzWi82N1hadEdDby84cWVTLzZsY2V5aU91eGNM?=
 =?utf-8?B?NWYxK1ZCTHQwNU0wQ3dxSm9vNjY3WTNmcTRaQlp6bGNsWEdZOStNSkFxMU8v?=
 =?utf-8?B?VVIzdEtkcXEzNjlnd0ZZN3ZWQk9vK2VuRWR2YkNFbWlnZDVtYzRZcjhvVGNY?=
 =?utf-8?B?S0t3SWlWVGpBMEJxOCtYYzlDb2N1MG1jY0FpVUNlcEhndjFUWVRaaFppRlJP?=
 =?utf-8?B?OTZpaDErU1I2dEMyczlqVEpieEFCc1NqZjBWUldFWmxvcWRVZHZLd29KVnl2?=
 =?utf-8?B?cEJsdHNjU00rSXVPcWw5UEhQY1phTmNFODNSMnZCQzFEWWFFeTJUQ2Y5Q3pn?=
 =?utf-8?B?ZXRxYkhLZVZVa1NXQU5UaHJ5SGs2aHFiTmNIYkxnN2Jha0wyYUFqQ3VIYkJ3?=
 =?utf-8?B?MGlWd1pieXcrQzhrSWI2V1RBWGZoSGoxVW15eXhWWVBuZ25LMk93MzR1dUp2?=
 =?utf-8?B?aG81Rm9uRVhCd0JJallrZ1d6eXpQR3UrL01GZ2tKSktYUGtvQW55d1VuQ2sy?=
 =?utf-8?B?QWh5TGJsSWxWeGxYWFZqbm1KcmJ4ejFuZittbUhlcEJhR1hiMVNsYTVZMDJO?=
 =?utf-8?B?cHdTQU9HQ3d2a2tMbG1Ib3RxZXVkOVRRZkdPK2lRZGVrejg1RTBYTEdXdnNX?=
 =?utf-8?B?UXNQQkhwbFVQUktkZHlpalZjTk1vTnQ3TjRJL0crVDFSNi9NbnMvdmdUOUd6?=
 =?utf-8?B?SlVNbnBOeUl1S0ZtcDgxWk9qN092T3BvUENzdzk1Tmwzb1VFRXBWYjFiSFRi?=
 =?utf-8?B?TzVtSVRjZnliOER3WGt0cFltUEh1V0ptWDZDL1hla3VkTlh4ZnQ0dDJvSHJp?=
 =?utf-8?B?TzJLL3ZvR3JXcU9KK3AyOHpzU1BoRzNsUnpUVEV2ZlZ4cWY4YXNQVXN6ZjJL?=
 =?utf-8?B?S0JzSk1KNklURjhQYkJTN1U0L2RYNVdIL1FkZURuRHB3Y29icVpZV3pKOWEy?=
 =?utf-8?B?Y1ZLVllIeHZaUzRrQVhBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3AwYW5wK2hzUWs1QXYxU0o3ZEdtV0F6TzZQZG1ORk9TTStWRStrb2lQR20w?=
 =?utf-8?B?dmplbXF0aHdZbXBYT1JaZlNVYzF6VHJ0RldMVWQ1SU5RdEl1bFVmSEttN3dw?=
 =?utf-8?B?SUhLN1hLOWJFVUt4Y284U1R3b2RuT3Z3d081Ry9keWFzOU9WbW9abXhEU0k1?=
 =?utf-8?B?NlY2VmlWV2p5L0N0Zm5Ubjh1em4rcG9EOCtQblE1RGZvNS9MaHRNUTdQZVpr?=
 =?utf-8?B?Q09VQjMvVC85Zm1ldlBWajZvaHU0U0dOMitpQVVUVHZZTCt5ekw4a0VicTlJ?=
 =?utf-8?B?OWdsMk1QZ3VHV3FneHJTRHU3aGpwTFJ3eWZZZ2ljdTcwenRiVUxPTWRWcklv?=
 =?utf-8?B?b0daVW01QXJrNC9NdmcvcDFjL2prR29pajRFSGI1RlRreG9kcGltcVpUOVM1?=
 =?utf-8?B?ZU9VRldXV0x4dHZER0ZFMzB1NzNyR2tvTzFmdzUvem1xelc3L1BBTlIrYlVX?=
 =?utf-8?B?ZHIzN05QMkR2QVYxclpkeklsRVBmeDViQXJGY3JMdHQ0enZ3ZkFjT2RnanNk?=
 =?utf-8?B?bytJZklqc0YzRitINWc0UVlkbVV1NkdwZlJ3Rk5HS3ZybkdyZ3QyRU00TDZj?=
 =?utf-8?B?QWxQVURMNE13bTFRUlNJTkkwNWRRS0N4eTc0MnFSQ3NwUjc2N0o2UWNGNlRr?=
 =?utf-8?B?QVdzbkc2Q00vMVAxdmNwSVNVQzNoWXE3OTE0OVhMZnR6WjBJakxsV25CNHpL?=
 =?utf-8?B?NTIxMlVkT2laMXVJZGRUU3hYdHJDSkczTjdrRjRNUnppL3JsQkJwRGhwVGsy?=
 =?utf-8?B?bDVvK1orSnU3VkczQTdlaWJRNWYzOWZPamIrdU1kOU1FL05vMWp5S2NtL2Mv?=
 =?utf-8?B?a3p6ZmNZWjN3dlgxRzdqdllvVTd3cDJYN0czOWJ4R2ZybnphY0s4ZUtQc2Ri?=
 =?utf-8?B?MFIyMmJIS1ZJanpZTUROY2V0SHBLYldUYklRb2xlUnl6YVYrblBCa2tORTF3?=
 =?utf-8?B?QmZ0VWIwbi81VkFNT3VaNTJmTFNuWGhpZHQ5RDhCV3JOK2FoQWZaenc1MWts?=
 =?utf-8?B?a3hJdHNrcXpxOW1GQ1BUdFNZdG5DdWRhaXUrckc1YXJZR1lWNW5LKzVucHRR?=
 =?utf-8?B?N2RaY0JFa2t5aTEyZ0E5RXJFbW9UUUdBQ3lzQ1JHZXk4NHBJbklHUmNMQmJq?=
 =?utf-8?B?Z1lWSVZCRTM0UkphbS9MUCtHOHVFTmx4Q1lQTklyWnVOOXFtOTFSV1dvUDhT?=
 =?utf-8?B?OFVka3BOZUhjU1NtUk9sL2FURUdrV2dVS21ZcnN1SHZwYWhzQy8zNEpIYzND?=
 =?utf-8?B?S1J3R1IzUmQzTGZ0eDFnbGFvZTdRWDJDNzZwbENkc0tCMjJNbUxLdTZFbldK?=
 =?utf-8?B?dXN1ZFRSTFRWeVhLV1pTc2U0ZDFSd2lLWmFGME5LUG5hQjZvY0prajRoMlF5?=
 =?utf-8?B?ekh1Z3FVM25OQTJyR1ZRY0NHZStoczkrYXpCc3hldnJoaFNnMU5QMmtBU3Yw?=
 =?utf-8?B?bVhmd1I0TEp1cTNERUZ2OVdENHJQbXBoaVhWSVZEdDN3eS9GeFVvZFk3Z0xR?=
 =?utf-8?B?ejF3eWNCWXFrczFFYmxjWlEycTFRc3BJMDMrNmoyaUVSd0pnenJIeWJZVnZq?=
 =?utf-8?B?SE1XZVZXVXlSS2R1WUdhZ1J6Wm1JTXN4dTZScHNoQlNaZ2tjcE5oc3laTHlM?=
 =?utf-8?B?N1FJaU8wSG90UkVGT1o2Q2czU1djNTMwZjdsL3VvOGRrd0lvRWdMbjdCaTZB?=
 =?utf-8?B?TUxPNGJ1NmFIcmFmS0thbk5zTkRYRW5jeENFQmF2Wk9LdmtYaEYwbDY3eExF?=
 =?utf-8?B?ektLL1NEWWc0MkcwS2xuMTFsR3lEVktpMXJMS0tGTWtMWlVibmVweXAxRFVS?=
 =?utf-8?B?RDdzK2JTdFRnNHRTeDlnRGdxamtKeHdzT1YxTWtaM2ozWDE1RVRvb3NxSGNN?=
 =?utf-8?B?Yml2VW9rYmhqNmJpNGRjbmpSMjZ0WXBUTy9BUWk4ckszL3BkRFpiTUsxR01H?=
 =?utf-8?B?Q0NJZHVIMzdHSFJpREZRa0xsZmZxcXg0V2lkTGJmeFZDN2FPUUIxNVJjUmUy?=
 =?utf-8?B?Mm1YeWpEN0diN0JISFBWZVJzekU4SU85SUVibnA1d0dKS3J0L1NveUFjSWNZ?=
 =?utf-8?B?MDdnWXV3WHVVNDFHckd6UTk4dElnYnB1S2hwenEwSzNYWHJ0cVhMNzdOdk5X?=
 =?utf-8?Q?c+DmQfl+pqX8YshqsgazCUbjg?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c809b15e-3bf8-47f4-b339-08dc9c31c56e
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:01:16.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GObrySNl25nSK5yHfkWNOipU6zuoi3pQCJNAADzevgkVtr6Duh6GF4mwIe1vIRbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10014


On 6/22/24 21:12, Andrew Lunn wrote:
> On Fri, Jun 21, 2024 at 01:26:33PM +0200, Kamil Horák (2N) wrote:
>> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
>> Create set of functions alternative to IEEE 802.3 to handle
>> configuration of these modes on compatible Broadcom PHYs.
> What i've not seen anywhere is a link between BroadR-Reach and LRE.
> Maybe you could explain the relationship here in the commit message?
> And maybe also how LDS fits in.

Tried to extend it a bit... LRE should be for "Long Reach Ethernet" but 
Broadcom

only uses the acronym in the datasheets... LDS is "Long-Distance 
Signaling", really screwed

term for a link auto-negotiation...

>
>> +int bcm_setup_master_slave(struct phy_device *phydev)
> This is missing the lre in the name.
Fixed.
>
>> +static int bcm54811_read_abilities(struct phy_device *phydev)
>> +{
>> +	int i, val, err;
>> +	u8 brr_mode;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
>> +		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
> I think that needs a comment since it is not clear what is going on
> here. What set these bits in supported?

This is an equivalent of genphy_read_abilities for an IEEE PHY, that is, 
it fills the phydev->supported bit array exactly

as genphy_read_abilities does. The genphy_read_abilities is even called 
if the PHY is not in BRR mode.

>> +
>> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
>> +	if (err)
>> +		return err;
>> +
>> +	if (brr_mode) {
> I would expect the DT property to be here somewhere. If the DT
> property is present, set phydev->supported to only the BRR modes,
> otherwise set it to the standard baseT modes. That should then allow
> the core to do most of the validation. This is based on my
> understanding the coupling hardware makes the two modes mutually
> exclusive?

 From my point of view relying on DT property only would imply to 
validate the setting with what is read from the PHY on

all code locations where it is currently read by bcm5481x_get_brrmode. 
This is because the PHY can be reset externally

(at least by power-cycling it) and after reset, it is in IEEE mode. 
Thus, I chose to set the BRR mode on/off  upon initialization

and then read the setting from the chip when necessary.  The PHY can 
also be reset by writing bit 15 to register 0

in both IEEE and BRR modes (LRECR/BMCR).

The device I am developing on has no option for IEEE interface but in 
pure theory, kind of hardware plug-in would be

possible as I was told by our hardware team. However, not even the 
evaluation kit for bcm54811 can be switched

between BRR and IEEE hardware without at least soldering and desoldering 
some components on the PCB.

>
>> +	/* With BCM54811, BroadR-Reach implies no autoneg */
>> +	if (brr)
>> +		phydev->autoneg = 0;
> So long as phydev->supported does not indicate autoneg, this should
> not happen.

I also thought so but unfortunately our batch of bcm54811 indicates 
possible autoneg in its status register

  (LRESR_LDSABILITY) but refuses to negotiate. So this is rather a 
preparation for bcm54810 full support. Unlike bcm54811,

the bcm54810 should be aneg-capable but I cannot verify it without the 
hardware available. The information around

  it is rather fuzzy, we were told by Broadcom tech support that the 
54811 should autonegotiate as well but

  the datasheets from the same source clearly indicates "no". Same for 
the bcm54811 evaluation kit,

there is no autoneg option available (only 10/100Mbit and master/slave).


In conclusion, the idea was to support as much as possible but with 
given hardware, only a subset could be verified

  - that is bcm54811 10 or 100 Mbit on one pair and forced master / 
slave selection. As for the other possibilities, I only

could test that the autoneg is probably not there or at least it does 
not function with identical hardware on both ends.

We also have a BRR switch and some media converters (BRR/Ethernet) from 
other manufacturer with bcm54811 to help

the development and all those are fixed setting only, no autoneg.


>
> 	Andrew


Kamil


