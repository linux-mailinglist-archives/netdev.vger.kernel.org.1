Return-Path: <netdev+bounces-128507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7A979EE6
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB00E1C22F9C
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8F1CF83;
	Mon, 16 Sep 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U0XgyHzx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E017C8D;
	Mon, 16 Sep 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481101; cv=fail; b=Wk40Ciq737ztVB7XiilzjuNK5av1YzbeY3b5zQwFCxc5nspLFSrdjz/XNCwdLaGH07crJNEFBXazsN/DN/p4iQUsXL6dTaFTX5nSTkahHadlPSMJIIMUvv4D1Z6eTrDv2dHVdYDtrEmPjEn41RUeLg/+YcUKodZE3T1wnt4t9Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481101; c=relaxed/simple;
	bh=n7HIL9MUqvHv/gvOkzhSEw3WIWmRobEk6IAfz9DyiI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GogVrszg9dARvEZ84eWcKsVwFTdeHVchys6VKasiIEFPXptQ8G7ImCveMvMRoH4bEHf1kCpsLHZe77gWR9Y6/VbPHGf840nZ8pGjlCqOSphruT8pF/KNr8FDxRFxz27SNfLaoX0RBnjh01fDzm3e0IDzxDVeZKGAmwjlWr1ZIeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U0XgyHzx; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7ouoxG24iCxIlPL5J8clwB3sK2NJcYIBPigjwBSxMtN0UfYIXDSLqszh7Z0nZbODfydpS/QapINSSj6WmmL6T56RV+aVryFO2PhIhKK3Lb0HTyhVNfeEmdxtYrchNzo/iL0M5Er2EK7Dg1woM0m3KBbZcdIT990Thzvj5HHz+/9VMDA1LkMyuotJakRA1IdaT+XQF/3PiZJUHzIUV2MLPC4WHD2Td6nFOsUMqFkP4I7WgAjrXGBSXJG8zgTKuT49VKrB/r2u8p0b1uWWcEzilJDwbuEf1twiybLYA7yqgVl42wJkGrTjV2MgJKMmfwZEJXMbhcmRbuB6YFTZL7aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPcVsaIecjYAwyERCTdZMnKnFZIhlmSludpUnvP1eAs=;
 b=JRlfpqf0RhwcmfWNhamuL8xDqre2l25bp6P0HwJl83HiBBWcjaxTOPfVJ6/1XkMRVOPnXCpiGlN8YVOcMjY3PfY/oXHOEASVAFv5+WIdXgXhoLTOA57DpEKIJJfyJ4xMb1fltyPD4vkcDgdQyCPk/LHslJ3ezPLm3FlwBX6t+9xBKp+cd/QRiNZd/jNuHolz7rL38udzskJOob6ckSGigNVGt6eMFy5SYaU3j2iWDqPbe8CEhZHtDid35P2XqsrhTc9V9D9sCszTzA9/YDp0pRZ5/CbGbsMIiC2BMMhPtw39xRPJNRpslKsr+Gx3kk4XrBws5JlAC4l9Y9VWRfu1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPcVsaIecjYAwyERCTdZMnKnFZIhlmSludpUnvP1eAs=;
 b=U0XgyHzx8+aRkG6fSzYJFusrE+TaMsEk7UJp2KzJ+HhdTVsRbr35uLgPzt1JY0ZSr2ZvJ7+4reFVKVzt80Rh4oWShBMSlOxm08pU4jqLrCKdhrLcrx63UZPq/4c/dBzwFgfx5KJklWrHdG0ovuvoxKBbjOZMpP72JX53+a9/UvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 10:04:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 10:04:55 +0000
Message-ID: <59ba9f9d-8372-3c04-9684-0df47a7b4c42@amd.com>
Date: Mon, 16 Sep 2024 11:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
 <20240912123505.00006688.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240912123505.00006688.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 8380bcda-be6e-4d5d-d385-08dcd637038e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXRaSnFjeFdwcFg0akgxNXJRNmlCY0V0TVhnUEE3cFpBV21hS01SdTlUb2tw?=
 =?utf-8?B?OE1nQUlhaHlDOVRsRUwyUjRlNHB1Ym54bHppWkFzSUlZdG94b042Mm8yM1lZ?=
 =?utf-8?B?bURqWEU1SDcyTnVFaXBWdGpHayttYU80TzR0cys2UzNTZjkyd1B6Yk5CSGVC?=
 =?utf-8?B?dkdCYlhrN1NJTGRWbnNJQzBLOGJBb2p4U09XV2puVTE4L0R3bG9ia01XZXFw?=
 =?utf-8?B?eDhhQVZLOFQvUjhFYkdoNFdLNVNPb0ZGRFlkUk5jQWlka0M4a29aSWZXejBJ?=
 =?utf-8?B?ZUNWcG84emcxMTdKYUtZSTN3em15eWludUd6U1JTQzJQNVVVa1JJSUJUdDFJ?=
 =?utf-8?B?endidWRSQ3l3U0dCcCtxL0Nic3pSTlBiZ3J1bHJQcE1aOGtjL1FVUFc4WlYz?=
 =?utf-8?B?VWRkaXMzSklCL0l2WFpobzlYTStvbmJPbkRRTlNkc0w1T1JDb0JMRmdmaHRL?=
 =?utf-8?B?bDdUNUxnL3l6MWk2SDVIUHpUeG1qM0g3cGdzS01Xd21qUlJhM1JDZ1Z3dHVS?=
 =?utf-8?B?OGs4VXVVbGF0SFBJeDlEa2MzSFhhd042aktIeVlzWGpSUDVnUDY1N25iRjc2?=
 =?utf-8?B?L3o1RCtlL3hoc1gya25TNDFRUDF5R3hiTGoxbGhkOEF5d0MzME43M1RsQ3Ji?=
 =?utf-8?B?RFBFTjczM1JjVDhsZ1BVMlE2UmlDNE0xMWp3ZlVnSkRPVUtxVmRyUTcvYzN6?=
 =?utf-8?B?OTZzbGkvUkRKQUxrNWlrYVc4WVdIK2NOUFdRdkFKUUVZeU9MaVc1aGJ4MTcr?=
 =?utf-8?B?WFBHZ2d2Y0ErRjFZdnBDclVpTDFOeFpBQnRWZjhPeFJOVmtzcStMZFliTXM4?=
 =?utf-8?B?WmJSNFlZNWN6SGJBRE9oVnNWVFg1YTlDT0R6dzFnZm5zdGRyaDZIZktPVG1M?=
 =?utf-8?B?UnJCdG0xeWF2TlhxVXlZNjd4YTBtQ2NhN3hLMW5mSmdRR2NsazI4NUoxbmZ4?=
 =?utf-8?B?VTAvRTN6NUVkdVYxRmU5QjNsMnlFU2lSY1IzMVNwQmMvK3NaQjM3TERLeHlD?=
 =?utf-8?B?QjBSWEtLa0drNVFlZEZ6VFRlWWN0VVZxU3E2YW1xYmViWDE4NlJSY3FDaGZN?=
 =?utf-8?B?dnU3WVVrZlprb2hRaVVKSmp5eDFlMEc2N3RzN2t0cVgwTXQ4cHFBVitkOXR4?=
 =?utf-8?B?TEhtOWEvdVJnMFdEYUViOVpGdTg1Skt2bVpqK2kvNFVDK0ZDRWN0bWlEUHRp?=
 =?utf-8?B?eW1oOUFqVGJrOTArazFqZ1o2bHFRMTNQWTd3Y1l6cDYyN2lkajBic3E5eXMz?=
 =?utf-8?B?MlRlVEQ3K1pPU2s5TW1xTUZMd3huNUxHeDBISGZiVGM2TmJldElrRXZ1TmRM?=
 =?utf-8?B?c1NmYWNTUTBHZmFpY0lCQldKYjJkT2FpeUtZS2M4Wnh4MGFRaXFPSTJxTXVz?=
 =?utf-8?B?UTNsMkt1cHU0VnJjZ1FjV3E3Zk8zeHJhcnhXTjVra3NUNmVmOWZoeXZLa2pm?=
 =?utf-8?B?dCtqTmEyQmFIU21Kb2hqV0xQYXhST05FQ1ZPU0tqcjFOSnNkS3RleDM1SEQz?=
 =?utf-8?B?RGVkOTJacDdxUjJXRW9xR2lxa2crUkl2TVB6WWpCY1c1V0RjekFjNlJjWm5N?=
 =?utf-8?B?cFdsZmFhYUNwY3NsS1NyYldzZjNNaUVUNFRZMHVLa1BMamw0ZHM5RlAxQjNk?=
 =?utf-8?B?VnBncit3VGlreENVOUtsV0kvK3huOXBNWDl0VjRtTElsZjluZWxUOWk0QzdM?=
 =?utf-8?B?YWtjOFlOUHFpTE5mQXRHWGRxN1VWMytDVEpVU1ZQK1N6dXBBT0VDOGNjL1No?=
 =?utf-8?B?c2tXa28xejVZdmRHR3pqNmVvRFpPV2RpMVkrYktZTVpsdGI5RkRtT0NsK0FI?=
 =?utf-8?Q?R1QmYUuHi+M+WbX5HK7mS6yX6rw6edd5cDv90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1I2VFJuRXFudzRHc3JJZ0IrVFpDeWxzWFRaNkVxcG5yUkIwTm50UEljdjZR?=
 =?utf-8?B?US94SDh0YVF2SDlJSlkraStwdmJIbXgyM0pPdGF6US9kdVJxZGNJT0tGaU04?=
 =?utf-8?B?SUNJdlp2UDlsZXh6aThNckZ2eHovcDVvQ2pTNzB0WFR0MW9YaU5nb3I3d0Jy?=
 =?utf-8?B?RW5vcTFOQ0N3ZkVtSmUwOTlSREc0OFkyUlVSTFBYblZFVEN5a3ZhTkFLRGQw?=
 =?utf-8?B?SldMVkZ1eWtodmtrYnhDN25Bc3FpQ3FqN1RIaG1rY05Ob3c4YmE0bUd2U2ho?=
 =?utf-8?B?ZnkvQ0lxdHYvTUFiUkV2Ri9GdnlKcWF4Uys0N2hnVDlYTnZmVGFweit1QW4r?=
 =?utf-8?B?VzltWEFDRGJTcUI1SHd1MXR1Z2ozUjdtNkNWV2NWN2dqQkw4UUhSZWtIRm9R?=
 =?utf-8?B?bmY0RFRzUDZ5QkJzMnVMVWtTS2YrVTArbXZqa0VMRElGMFZTYkNhcnptOUdQ?=
 =?utf-8?B?Y01SVE55VzI1ZEZkTTN2UHdxT3pudm9MbjhNcTVldGFKUTF0dWRlM1pNSU9H?=
 =?utf-8?B?ZEZ5TDdaQVlnUnliQWRVendCOXNLZVRjMDFSMUczVnczVWNoWnFEV3dxemZk?=
 =?utf-8?B?ekVyL3N2QVJYd1VSRXViMFBMU3JnWndoaDBMbDlKVGdpRXYwL2s4MytwOVJw?=
 =?utf-8?B?WTB3Q3dZSm5lWmY0aDJBeHhzZHNSWHRqZWdkRTI1MUQ2UEh4cVB4NTM3ZHJV?=
 =?utf-8?B?OVE0Yy90WmdVSWZSVTh1TFdKUTZldUw2UW14S3F3S3AzN2crVVR1RTRoS3My?=
 =?utf-8?B?WEtCeThhb0FKbDBzajArdSthQ1RZckR2T3kwSGxIeUQ3VjNuQUQ4Wi96RnY1?=
 =?utf-8?B?eGdBS2JOZkFGTUxFK2JZa3ZoY0ZDcFVaL1d1Ulp4SXpGaFlOU1ZxZlpzbTNM?=
 =?utf-8?B?eS9ZZEVNOTZhZXZHbUJuVmpxUXZ0YWp4SDY3ZHlDM1NaZU4xVmNCZTVueUF6?=
 =?utf-8?B?VU94dTZDQUk5clJhY1ZGVWF4ZmpwMEMwN3BnVGFhOUY4TjZWaExHM0JXTW1r?=
 =?utf-8?B?R1VsNlRrU0ducUtsSnFwemgvQmYrMDNTditVbDl0Q2w0b0x2SEh3UG5pR2Fr?=
 =?utf-8?B?TEJuQUVFZWlGNzJpZGhxMHhJUHE5eU83WkRpanR3dlEwRjdnNmZ6RXdRaWVm?=
 =?utf-8?B?c0FoUjFIVENqYUNSSmxjSmcvZHBNYU1kc2svMXNVU0dvdzBWWUxsL2l1WmVN?=
 =?utf-8?B?ZGNYQlJCWUJSbFV2REJsY3VlMk5FVmhrU20venBnSzlwM29mVFNMS0FkVmhW?=
 =?utf-8?B?SmtmSHgyQVp2UThEZ0tvb0xabVVpSjlIZktVYlJPM25XMkxtcWNkTkZzbUpw?=
 =?utf-8?B?NEtyK1VtR2U0VUNucm81citlWUN4eGlvVG5TTm1LSGxRZFpiWS9QVmtvMHRK?=
 =?utf-8?B?RzI3TDg3ZUhCdlVtbi9LMDV6V1EzamJpM0dMR0s4eVRvMG55U0dmT2wrMkE5?=
 =?utf-8?B?aDNGem5nSHVkanlQaHc3TTR0TWpyRlZlVXVMTE8wcE9DUTYzeXYzSnRmYnc0?=
 =?utf-8?B?SnVsN2lhL1E5dCtFdkNNZnU3ZnIvNGEySXBoQzdBOVl3M1BYRzJyWndxZFhG?=
 =?utf-8?B?MTU0eHN1eGUzMFNmQVlPM3ZzOWFhK1o1WUk1cjJKMmx4UHo2N0NoSlVKM1hk?=
 =?utf-8?B?MkpNNWNzY0xxY3c4R2FaTStyeGRSUS9hbW1USHRYZjZyT1FzTkRleHVldVhx?=
 =?utf-8?B?NXJ6QUZPTWp6VFljalBuQjlHdGtxcEx1b2MrOVIvamhUanBENlVUNTlxU0kz?=
 =?utf-8?B?Tyt4VGE1NUNzTTl6dDVSaExXMG1COXd6cnlaOWd0bTZ2Qk5BVGxtV0w2WCtY?=
 =?utf-8?B?THNQWmk4WkJoY3pVdWpKVHZaUnpwM1prN1J1V0ZGQkdlaTZUY2F0WHdsZ2VB?=
 =?utf-8?B?N3pJMFFaRlkzbnVOSXgwY0E4V0luOStwKzBIcTVnRXlxRVZ4czRpclNnT3Y0?=
 =?utf-8?B?VVMxemFYNVg4d1pJOU0rWkxlQjZTaTF3aElQNWU5T1h5VitGMHE5cmg4ekNm?=
 =?utf-8?B?ODNzelM5T2hJMno3bGdPdXNreGRIS1FTOGMrVnlwaDY0Zjl2ZjFLRzFVMU1x?=
 =?utf-8?B?MStWWWhjdjFPZzFFczdTOVVWYytsQmdNQ0M2Z3dQMFNOblB5M1dtUUl2Ym5Z?=
 =?utf-8?Q?woLRhPmb1TaOKa+BlGepOKQfk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380bcda-be6e-4d5d-d385-08dcd637038e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:04:55.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88T7lKYBI+p1sQT9oapEYvQvRxBfm8TBQt51oFcLIdV3t33PsPWoIkjgXMeumbYbcpfBygXrLjDb93GzMQ0veA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644


On 9/12/24 10:35, Zhi Wang wrote:
> On Sat, 7 Sep 2024 09:18:17 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Add SFC ethernet network driver as the client.
> Some thought when working with V2 about the driver initialization
> sequence. It seem the initialization sequence for the driver is quite
> long (since we do have a lot of stuff to handle) and there has to be a
> long error handling coming with it.
>
> Thinking the usual driver initialization sequence is long enough with
> error handling sequence, would it be better to lift this efx_cxl_init()
> as a initialization wrapper for the driver.
>
> It can take an init params and handling the initialization and errors by
> itself according to the params. (The new efx_cxl_init() just
> call the wrapper with params)


Sorry, I do not follow your comment.

If you are suggesting to efx_cxl_init being the main init function for 
sfc, I'm afraid that is not easy to happen and I do not think it is 
justified.

Thanks


> Thanks,
> Zhi.
>> Based on
>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c             | 52 ++++++++++++++++
>>   drivers/cxl/core/pci.c                |  1 +
>>   drivers/cxl/cxlpci.h                  | 16 -----
>>   drivers/cxl/pci.c                     | 13 ++--
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        | 13 ++++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 86
>> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
>> 29 +++++++++ drivers/net/ethernet/sfc/net_driver.h |  6 ++
>>   include/linux/cxl/cxl.h               | 21 +++++++
>>   include/linux/cxl/pci.h               | 23 +++++++
>>   11 files changed, 241 insertions(+), 21 deletions(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/linux/cxl/cxl.h
>>   create mode 100644 include/linux/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..10c0a6990f9a 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. */
>>   
>> +#include <linux/cxl/cxl.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct
>> *work)
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
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state
>> *cxlds, const struct file_operations *fops)
>>   {
>> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode,
>> struct file *file) return 0;
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
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
>> res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_ACCEL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n",
>> type);
>> +		return -EINVAL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file
>> *file) {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 51132a575b27..3d6564dbda57 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <linux/cxl/pci.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..eb59019fe5f3 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -14,22 +14,6 @@
>>    */
>>   #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>>   
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE
>> 0 -#define   CXL_DVSEC_CAP_OFFSET		0xA
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
>> index 4be35dc22202..742a7b2a1be5 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id) struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct
>> cxl_regs @@ -815,12 +818,14 @@ static int cxl_pci_probe(struct
>> pci_dev *pdev, const struct pci_device_id *id) pci_set_drvdata(pdev,
>> cxlds);
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
>>   			 "Device DVSEC not present, skip CXL.mem
>> init\n");
>> +	else
>> +		cxl_set_dvsec(cxlds, dvsec);
>>   
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>> diff --git a/drivers/net/ethernet/sfc/Makefile
>> b/drivers/net/ethernet/sfc/Makefile index 8f446b9bd5ee..e80c713c3b0c
>> 100644 --- a/drivers/net/ethernet/sfc/Makefile
>> +++ b/drivers/net/ethernet/sfc/Makefile
>> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o
>> efx_channels.o nic.o \ mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>>   			   ef100.o ef100_nic.o ef100_netdev.o \
>>   			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
>> -			   efx_devlink.o
>> +			   efx_devlink.o efx_cxl.o
>>   sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>>   sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o
>> ef100_rep.o \ mae.o tc.o tc_bindings.o tc_counters.o \
>> diff --git a/drivers/net/ethernet/sfc/efx.c
>> b/drivers/net/ethernet/sfc/efx.c index 6f1a01ded7d4..3a7406aa950c
>> 100644 --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -33,6 +33,7 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#include "efx_cxl.h"
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev
>> *pci_dev) efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
>> +	efx_cxl_exit(efx);
>> +
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev
>> *pci_dev, if (rc)
>>   		goto fail2;
>>   
>> +	/* A successful cxl initialization implies a CXL region
>> created to be
>> +	 * used for PIO buffers. If there is no CXL support, or
>> initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy
>> PIO buffers
>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(efx);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with
>> error %d\n", rc); +
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c new file mode 100644
>> index 000000000000..bba36cbbab22
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms of the GNU General Public License version 2 as
>> published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
>> +
>> +int efx_cxl_init(struct efx_nic *efx)
>> +{
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	efx->efx_cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!efx->cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl = efx->cxl;
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		kfree(efx->cxl);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	kfree(cxl->cxlds);
>> +	kfree(cxl);
>> +	efx->cxl = NULL;
>> +
>> +	return rc;
>> +}
>> +
>> +void efx_cxl_exit(struct efx_nic *efx)
>> +{
>> +	if (efx->cxl) {
>> +		kfree(efx->cxl->cxlds);
>> +		kfree(efx->cxl);
>> +	}
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h
>> b/drivers/net/ethernet/sfc/efx_cxl.h new file mode 100644
>> index 000000000000..f57fb2afd124
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms of the GNU General Public License version 2 as
>> published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
>> +struct cxl_dev_state;
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_nic *efx);
>> +void efx_cxl_exit(struct efx_nic *efx);
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h
>> b/drivers/net/ethernet/sfc/net_driver.h index
>> b85c51cbe7f9..77261de65e63 100644 ---
>> a/drivers/net/ethernet/sfc/net_driver.h +++
>> b/drivers/net/ethernet/sfc/net_driver.h @@ -817,6 +817,8 @@ enum
>> efx_xdp_tx_queues_mode {
>>   struct efx_mae;
>>   
>> +struct efx_cxl;
>> +
>>   /**
>>    * struct efx_nic - an Efx NIC
>>    * @name: Device name (net device name or bus id before net device
>> registered) @@ -963,6 +965,8 @@ struct efx_mae;
>>    * @tc: state for TC offload (EF100).
>>    * @devlink: reference to devlink structure owned by this device
>>    * @dl_port: devlink port associated with the PF
>> + * @cxl: details of related cxl objects
>> + * @efx_cxl_pio_initialised: clx initialization outcome.
>>    * @mem_bar: The BAR that is mapped into membase.
>>    * @reg_base: Offset from the start of the bar to the function
>> control window.
>>    * @monitor_work: Hardware monitor workitem
>> @@ -1148,6 +1152,8 @@ struct efx_nic {
>>   
>>   	struct devlink *devlink;
>>   	struct devlink_port *dl_port;
>> +	struct efx_cxl *cxl;
>> +	bool efx_cxl_pio_initialised;
>>   	unsigned int mem_bar;
>>   	u32 reg_base;
>>   
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..e78eefa82123
>> --- /dev/null
>> +++ b/include/linux/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/device.h>
>> +
>> +enum cxl_resource {
>> +	CXL_ACCEL_RES_DPA,
>> +	CXL_ACCEL_RES_RAM,
>> +	CXL_ACCEL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
>> res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
>> new file mode 100644
>> index 000000000000..c337ae8797e6
>> --- /dev/null
>> +++ b/include/linux/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE
>> 0 +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

