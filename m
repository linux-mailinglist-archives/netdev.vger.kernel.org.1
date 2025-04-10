Return-Path: <netdev+bounces-181137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB8A83C27
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D89219E7C79
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1A1D5CFE;
	Thu, 10 Apr 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vwmv1MuD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E938F80;
	Thu, 10 Apr 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272732; cv=fail; b=NaLvm38O9hxQi6lz5GwU/0kZ56gFQKoUlsMw1067sUVAY4/NoWQ/ZIL8U/ur1A5DJYkpyrLZ/JDCBj73TdcEM3q+lSHK03GCuwHwNUueTprtmNhRc08v0T9E4oST4Ajc7Vybhspu6Ddds23a4PgJh2Hiv5Hl5KklK+p/B4iHT/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272732; c=relaxed/simple;
	bh=QNKzuWpPrBmSlBDWpsSrK7srZNt9ZntZQ+uv72C+W/4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3s2e1v3DaQjYtMaT2nu+7dp2jua7X27tnBmCx2dMLP3fpZuOutDBr6J482JNqVHOZ/3682JbKVTZrTbhfdGYc5HJUMWzgR5cKUe3QKQdqGAaGMtmu8bSFNbWdihm8rHXZKa/1w6rYlxIAlQU9gQVOcJiY3clwiTip/fW3SQgDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vwmv1MuD; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCqSjYCNJE0Mj/zIKwVPTvLZBXBnS2mmc+eZAmPNodgJYpLYSKSamQ9ukMXvf+lEmwjrWdbGCnEox9SFLJCAie+7upGus7/fJQRd8XodxjBpg/qmLA5wJZMgnk/krmjwvAH/ELn54n3GneqU9HJPuFxFMxHQCX8SdNLPhNekPIDYhThohQuPg20+5eLTq/fJqHdwoGpWBqSzSXejuFWTjsvM9iYiGCiCeScPFNMnQNGYKKnxqAc7FHM2CJrZ2EgI9G0tu5HlPNoHPD2oNGP8TIDOThfIerta0WDpSyoVts54kF9PmM7zkyzRsT+LaM6DOuWAPhIK+leDitbVEhdQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg+oreMZLi2BF8CtcGnlR3AOS5qK3NeVbp56P5gZlCk=;
 b=khUgr6cFckw70bxV54KXe6yWt8GYew2wR73TQ6hmFfteYT2j+DUTfC9nRcy4oxeqxDyba5pr9HuVri7FLvlk5TSwuIlkJmuZO4wVB/X3PfO4X2VDYe0pZB1Hj9GJXGNeEWusvyRZP8dYjTvE7GwA0E91BLBSFl2RQBt4JHT58OghJq/ay4muh7cPdAFoIoNZCsrDICGgrN1QXWvYS0yDKR7CYduZ57MVrODErgiyKqrL8i4CWJ1zrybq+Ybk4rHWGE06z90QgfeBHj/1AR5tlVmqcaDz1r81ghBmU2qJinYu6VhzS+fLk0difUJPtiyyIZAMgljcSsqaIpr9btNEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg+oreMZLi2BF8CtcGnlR3AOS5qK3NeVbp56P5gZlCk=;
 b=Vwmv1MuDrTyxCpUGV/IdSSqImHKJ0QBHViF6Z8Yd92x9Dh4W0Hcydfi/7sHA7rHsofyR6rDUiFEHnBIUTOpP7pywHOxTxp3MeoECRRgPKxzShMe43ZFD7wfw1dHwhKXVWWiBfWFRMSvnOjfbhiVlYl1ZrzyGhd61/8GmiLgi3sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 08:12:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 08:12:08 +0000
Message-ID: <671a2db2-1c67-43f9-8205-74b682043e8e@amd.com>
Date: Thu, 10 Apr 2025 09:12:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
 <20250404162429.00007907@huawei.com>
 <f1264e0d-5efb-458a-a232-e97d56763c7e@amd.com>
In-Reply-To: <f1264e0d-5efb-458a-a232-e97d56763c7e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d8223e-06e2-40b4-5cee-08dd7807631d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U09UZmtuSHl2Q2dlSzNHaFN5c2YzT0lCZWNTUTdiSm01Z2Y2REV5UXF4enpp?=
 =?utf-8?B?UXljd3k0NE1vZHFObEtNb3Jtd1c0QmFEejdzQ3k0SitMeXhDcS9mWXNNRWt0?=
 =?utf-8?B?QmQ3L0s2YXhPMW5pYldQY21IbTZLUFR4NG9sNXd0SUVFNE5ha0dmZGo4UnVx?=
 =?utf-8?B?aXA1VnZwQmZxS1lEUGR1UGpnRWUvSmNJV2kvdHdLOVVWYVg0MG93KzZLQlpW?=
 =?utf-8?B?L1lUQXczM1Y5WjFlS3VuT2J2SzVzaGF5TnhkcUM1cEpnU2o1V2hNd28xNWo4?=
 =?utf-8?B?NjhkSVQzdUFlVDkwdXVydWM0RFV3eGloc1dJckFOb2x6K0Njd3Ayc3Q3MmY1?=
 =?utf-8?B?alluV01XSlJvaVBsRTA2NTBsQ1poenl5dm9WOXdJOVpINE5KN1JXYTNDVGlz?=
 =?utf-8?B?NDd3Y3dRY2xOdW5yaisvc01XUGlJY1BOaDg3ZEdPRVNPYTBWQUhQaWx4UGYy?=
 =?utf-8?B?UHNGb2k3aDd0UDd3Q21GK0R2WkdFU0ord055WVd1UVdxc0hBUVVaMGNXdWg5?=
 =?utf-8?B?Rk9hM2c4eHRaUVZjL1NXZzNaQ3NWQkt6S3QzTkFBbmRQRXdsSU82MUdPcG1u?=
 =?utf-8?B?ME9acFhveUhzTmdaSWtacGFyYWFDRjhrWjRpZ1h4ZU93R0lGRWZEbTVKUmdR?=
 =?utf-8?B?N3dLZmRvakJTaFIzRVU4VEZ2MTBkRHVqUHp5ZXRVUWtaa09vbHpndEtxTnNC?=
 =?utf-8?B?OWF6SnpNWlpXUmV5bFlrSmF0b29EbzBmZ2w4eGx0Um1EVXB2aWFSWG5pemQz?=
 =?utf-8?B?VDlEQ0V0WUFUS0pzeWl1WE1CRkVGdnVJSWMzMURka3FJM3NPdGJvQkRIM0Va?=
 =?utf-8?B?TUdPeGtYQ2JkRGV5aEJyaU1Ib3RKZk1QRUw1RllnVDU0STEwV21SYm83UEhr?=
 =?utf-8?B?Vzl4R1dwWE42M0ZJMEtFbmJEUHB0QlBmLzlGTmd5ZVN5TTBTV0lvTEhMUzVa?=
 =?utf-8?B?L3RGMjkxWkc2b1QySlIyaWI5ZUNpOFhxczNwOEJRSnQ2U1J0OGtSTnNLRUI5?=
 =?utf-8?B?VGFRSWVYZkdMRkxpb09Da3N2MnRyTEFlTkd4bktQMGhZeTVXWDM3MkZsZkZB?=
 =?utf-8?B?SHFmdFVMd0ZzUFVLZ1NyK2JYQU5YWHladjVIZGc5dVViMDAxOG5VTjJKcGFs?=
 =?utf-8?B?d2cxT0tTZTBKT1U4cGdYNWt6eXl5NWMvRGR6eWlwQ3REeTFhNGdWV2JlTnZL?=
 =?utf-8?B?cGhoZ0FTOGE3ZWE3QmJ0Y1lqc0VGQ1NzV3ZhTzREa053anlJM3k4aWxDN2tT?=
 =?utf-8?B?U3lzUk9kV2tTS0lCZXBLVXRZRUMza3hSKzdEc3RmMmlka013a3pzdEg1RnJN?=
 =?utf-8?B?OUtBM21XbWpMK3h3NUhhdjhuVk9FNGUzdUJpWjdjbjBTM21GY242cG5pZUNw?=
 =?utf-8?B?K3ZmazlpdGtVRnJnK0I3SGxFVzVqemM0S2s3NlRaOEhNOTRIOHFsRE5sYWhk?=
 =?utf-8?B?RkMxMS9lbVJyaXNvUHVZRDVtSkhIdXNENTdpOU9XZEE4ejlaYUl6eHlEMXVz?=
 =?utf-8?B?NkRubXYyR0Y2NGJ0RFBwRFBJMCtSTnNVSG9xY25MZHA5alhud1BoV3NaR25h?=
 =?utf-8?B?ajNZcVFaK1kybmJ4WUVlOHcxK09zYkFzRXVtM3BTbER2OTlOdWl0aXoyUTNO?=
 =?utf-8?B?V24ybW04THk5dnExYWdEZC9qWU1mZDF3TTVNcWlhWGF2bElEM2hkRzhHeXJV?=
 =?utf-8?B?QytXRmYxNzZPUVMxcThUNy9Oc1JpOU1penl2KzErOGdVQ3hiYjBGS0lqVXgw?=
 =?utf-8?B?Y2JEN1h1SU9ieGl2Ym9yT3pVZ214MFZ4Qk4rQlhOcjRibDRSdUdjVkVEMXJC?=
 =?utf-8?B?UnpxbE5BdW80bjhwQS9WdHY0bVMyTkhvVnFIdzcwdUpEMXoybCtSekU3MXcr?=
 =?utf-8?Q?c7x1y7olKRyV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmdBUGZDRUZVWGc5UTlMMkd5RW1KcTBmTWluM0dxNlBoS1A4Y09Fa3duNFR3?=
 =?utf-8?B?L2RQMWJ6ZlQzTlhQRnBnaEYrWEQ2TG5UT245Z1E5QjJRalNvckRIS3UrU0hp?=
 =?utf-8?B?bzlTR3haR00rd0NtcTVvTmZ5aWpEZ2o0Z0pQWko1R3NFaUp2VlNVakM5UTlP?=
 =?utf-8?B?Y09YTlMwL0MzTEFRR2o1TWQramJRa3prT3NQc29TL2JHRU1UZWpURG1PejIr?=
 =?utf-8?B?N1ArOSt6czd1OEVQQmRSSXVFa3RKdGxENFozWWxwb2hFK2wyaDE4TnpwRjl2?=
 =?utf-8?B?bXJ4TEh0bG9BNXg5NlVmNFZ5aUpkeTFwbi9RK1ptMkY1UUhzdnZCc0kzaHZN?=
 =?utf-8?B?MisrTStzdFk1QmppOXFNTkFyWjBCQVBhQ0hIVDhYajlqR0l3K3dkMGk0TEV0?=
 =?utf-8?B?NlQ5Q2Q0cnNaMm5Cc3g2cHcwblpkUkJ6VXRWeHVzZDAvRFVtMkorUVlVSU1Y?=
 =?utf-8?B?YkpCNkxEUm42NmE0NEZseGJ4ZG1CUm85d25hVmNHcXVjb2wyQkFUcHA3VzZl?=
 =?utf-8?B?KzJnLzlMRkVYRk1PaW8wdURxMUcvK3BwMUZ3eFlNOU90WE9wcld4c1NpTFEv?=
 =?utf-8?B?Y0VTWWlNSmZiRFJzdXhwMVdlSXZWemVBanZObjVGWUNrTzJIQXdYcE4wVmlv?=
 =?utf-8?B?SHltd2xrMmM0MFN6ejVXTmlKVk5qMERUekNZMDNvSFBTK216ZDRZVk5oYlUw?=
 =?utf-8?B?bERCTExWcWJNeEpjdnBMcThCZ2pyT0U4eDRQc1RBTnBhNEdoNkxKdjBvNEov?=
 =?utf-8?B?K2R0Q0VHS04rRHRIQjkyRi94RENxeHl0MjU1N2J1djZzeTZ6LzJ1L3pXaHFr?=
 =?utf-8?B?VlU0NFljYUFkWUgrQ0NVbkxjYThjQmZTK0xHT1lRUlRUOTE0Qitwa0ZhR2Zs?=
 =?utf-8?B?djhFUFRkeHFXRWxmMGpMeGxDbUpYcWFGZm1GMXd1QmloYVpQWjNWOWVndHpE?=
 =?utf-8?B?a25Na0N5aVhReWtGWGM2ZlFFOW1ldmE4Z3Q0ZkV0VHlqbWNuV1pVcGsrQVpM?=
 =?utf-8?B?RDNIZGtEdUJtU09ucjlVcTBXRkNxZlVtdW9rYlFDL3Bzd1c2bVQ5MEhRd1Qz?=
 =?utf-8?B?QTM2OVJuWEF5S0h5YTBOZHoxOHgwWEIxL3ZkTWxBcGt2QXlPc1kvKzBtVG9R?=
 =?utf-8?B?WUdoTitpWUwwOTBpVW45QVdYdnVmMTAzZ0IvQjQ1czJXOVBYaVgwZDZzYzhu?=
 =?utf-8?B?Zy9BQjA3UDV0OUtsdngxRElnNUpBVFN5TUpaZXQrdm9lL3FpRC9YNzN2a0dX?=
 =?utf-8?B?ZW90TFZjQ3V1SXc3c2UxSE1JUVB3cG1PYXlQUTVGdDYwS0Y5S0RMK1BZOE00?=
 =?utf-8?B?QXZ4bkJENUI5VUp1VnlhMjB0UE5PNG9hODI0dEp1YzJqNlpNTkxDalFxc0ND?=
 =?utf-8?B?eEwvMzVHYTNaS1RtWW03VHFVTGFIT3dXeWQzcmJHd0ZSYTdVdXJwMjhnN2Zq?=
 =?utf-8?B?UnBJanRIYWM3bVoxall5U1BCdHNSb1lnZTNYSHVRSVhQUVdjTXByM2wvb1Nt?=
 =?utf-8?B?YUh2ODNaWmpkVnBHb3Jlc0dydTJHaXhIVzBPZGlLWk8yY2hrODBTOU52UVhD?=
 =?utf-8?B?M0hJWlI1dXVJWjFzcHExNXVqVWpmRVZhVTN1WmdFYXVuNkVGaWJQOWZrZjBq?=
 =?utf-8?B?R2Y1UkhOU2FtQ0d5K0VnVTFPL1E5QXprcnZIbHJPYmR5VnRRTzNxL3ljQlRt?=
 =?utf-8?B?WmdERHl6NHI5MlpCc2lvd2k4ZWtkWWxQc1pMZTh5QlJ2ZHRJc28xMVhFQ3BZ?=
 =?utf-8?B?dDBOenJZbzY4R3V0SXVCZmJUMFExNUl1VEMwZ1dCVm80STloaENpejZHZWxP?=
 =?utf-8?B?MFdwUjNHRHI0bmhjQXp5dEh0MGFhSy8wK2JaM3p0Z3ZOSjdNOG00TlFHTmR5?=
 =?utf-8?B?SnVYN0V2N0lCMlFWOVBlY3plYnlveGxsNTJMaSs0QUpSaGRMZ2Vzek00VFpI?=
 =?utf-8?B?cEQrTEFGVDRaYXg1TFFtQ0c5OVVGR0wrNUlhbHQxQlloWGVBSFdXalJGWWEv?=
 =?utf-8?B?bXFFMXhvZDVxZlhqNTgzU0pQVks1bkZoc2pieHBzVXRKcUJYeFA2MWJuaWt3?=
 =?utf-8?B?TUp2dktxQ2pkV2taZEdGeE4xanFsWUpYUFNJemZwL1dndE5kcnVvMitROVdJ?=
 =?utf-8?Q?0cxqAWdA+RHbsBZJD45rJYE+J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d8223e-06e2-40b4-5cee-08dd7807631d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:12:08.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkJ7XKn+V/pF1kwd8Fl32wpxazxxDqXnBcCq5mK6cMjoIpLahFE0S8wTUiuLt3uftpbNXRsxgjEUhm1Yb3HDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439


On 4/7/25 10:50, Alejandro Lucero Palau wrote:
>
> On 4/4/25 16:24, Jonathan Cameron wrote:
>>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>> -#ifndef __CXL_PCI_H__
>>> -#define __CXL_PCI_H__
>>> +#ifndef __CXLPCI_H__
>>> +#define __CXLPCI_H__
>> Might be reasonable, but I don't think it belongs in this patch.
>>
>
> It is as I'm adding the new include/cxl/pci.h file which uses the old 
> name used here.
>
>
>>
>>> +
>>> +#ifndef __CXL_H
>>> +#define __CXL_H
>> Similar to below. I think we need the guards here and in
>> drivers/cxl/cxl.h to be more different.
>
>
> I forgot this clash. What about __CXL_CXL_H for the one in include/cxl?
>
>

For v13 I will use __CXL_CXL_H and __CXL_CXL_PCI_H for those new files 
in include/cxl .


Anyone with a better suggestion, please tell me.


