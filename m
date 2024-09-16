Return-Path: <netdev+bounces-128541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3997A2E5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1F51C225E5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF13156228;
	Mon, 16 Sep 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8bcLw4s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C16155741;
	Mon, 16 Sep 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493142; cv=fail; b=d41w0FW2Wq/+Wh4h5KoIW9AjumK+Rrt/E+m6qTZ3wdAXZ5YXYO90rtnakhknYqNGB3SZ1BCRjGoiMVGUUVEzrN+KXoL3pEV45kVmS0oJStJRmFWwnWCoCrXv839DciYopafmd2E/lVT/GRh10Cv96Jk9yBWQRZTZYOxB1kitStc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493142; c=relaxed/simple;
	bh=u9p6jsE/PRB9XjBZiR5m2GyDOgOmGvlPy7oyheebv8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DMXviam9It4dQJdwLoh6ZDmsPs7tO6ONxcQKHh9LvhU8gfIkKjLo5SAkiVSPpX/TgzdV0KcfIjmtIOmBkkrRU4boqxJ51SnSBNs1wSlTdXfO1z/1iRPmTOLzWbz3lDv5VVl1yV/P85FRxsJtntCCcSR9/h6912yzKSI0UKV/5Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8bcLw4s; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ7fDZq4XnHm/N2x2V3zHCBC+6ODr1qfn0FMjq+xS1E7u4VNmclymAFlk+Q7A3PSK87Nl61ujpkh6BIfdVgBBFbP2UgMbBa5+iaMDtweV+mMlkn67XuNoCpDRKuIAXdgb0GXLCxC0IYeM4h5AVZ2OyPnuvIzuj6bH7WUh8zGT1kgvqpyaICyfS64B46elN/TIfWSp49YzVBrv4hu21y6o+bQVmDdCv5I0MzglzLV/Hhkxk9Gmd9cw4EUY+prL0yXqFETSnDmpFKjm5J2I5qspL7Qc0NPjyzkEVxt1hcXfuSqojhH0X7mPXYVs99+EsguT3J6SlsUEWM4JvxpZ4EH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCSlNDTfbxyFSpiAnrs+WK/sJtw93DNo3Bc+XqUFxzk=;
 b=th88YRdWEg/J+mMq47Cyrn8VnfIRIPKAnj48JpEvTjVWNjK5KA7ZeupnW2D6zyA+d21Lxo3HBsYUD616SOjUmBYW2kOFbjU+HAv4ysXNx3/4uHcttfcjzku/iGj3ERYhHTv2+3zDV+zoX966LBSpXAXacAKgPgb3DjByVZW+MW0XZa4nhV8FrpgjGSasXjvfULVBxQeQsXNjssFV1IHUuilQgADgty2qFpZWphpK5nyK9j6I02y8e/59woRE5fz4KNo7cL7/zKbS2x99iJKI0BPSaGvTawYasbYpr1vTuYipSI98MXZff7jPHPrIrhFA9LsuPm7ACVl6ZMdi/rSU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCSlNDTfbxyFSpiAnrs+WK/sJtw93DNo3Bc+XqUFxzk=;
 b=Q8bcLw4smisYrxCrOX4/6ZdqYPkyZpzEVGBhv8oMyjPcUfHerDY7aXylAyOSYjFdcjxReXUFSkBBxA+vpgWaDpSvA9LVK4tXOkV/FgwM2R0AhfSa9OUxfHHABASPr/PSNfMOOAGYZVLn0dKWzu6IHxq9qpVS0ss7vW/x9d5suSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 13:25:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 13:25:37 +0000
Message-ID: <aac5797b-48fc-525c-733d-2e777df9dca9@amd.com>
Date: Mon, 16 Sep 2024 14:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
 <20240913184319.00000440@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913184319.00000440@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 6558ddc7-7bc5-447e-9c92-08dcd6530d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGVIanZEWlVWaXlhbUdpeSthYm9kdWNaaElLYmhOaGxEM0haVUF6dXBKVEM3?=
 =?utf-8?B?cVV0NE1tbEE4NVN5OHlqenFwS3FYRGpYazdFclpiUHlialFJOGtGTVVvNGtN?=
 =?utf-8?B?UExIay9XbGFYVDNIelhrVmRpejB2UlI2WmtSTG1leXRvREZsdFdxT2pFT0pU?=
 =?utf-8?B?dzB2dFBRTnFkclkzUlFrZW5kbXJ5Qk1jcnhvbDFIRHdPSUk1YjJTT2lTL1hI?=
 =?utf-8?B?YkwrQXpjcTFJVDMzRHl3VWtwWlphdkxZWVd2czVlUlUySVI2Tnc0VVR6bzhm?=
 =?utf-8?B?N0UwYVRaaTVHRS9ML3FHNEJCOHB6KzRvVmIrekw3Zk4yU3FzMlNCMEJKaGJ1?=
 =?utf-8?B?WUdMN2trTisyVTVkZG00UXNaczhaY2pWWU5JZ09YdDdpK0N5RXEzSjRkb1dC?=
 =?utf-8?B?aUxVSXVodUxUdkFFSlRlbkk4aUxzNGxqUmo2VlN5aFVzZU12QVl6SG9Rek1R?=
 =?utf-8?B?OWt5SmU2VHZEZHlUN1I4MFZRbUJUNlFtV0VRNHNpazZWWnhJcmhGL3lDOXN1?=
 =?utf-8?B?dW1KSTEyMURuaThTUXh1OFRJSEw1R09YUUdQQVdBWGtnR0R6SzlYTTBkUmpH?=
 =?utf-8?B?SFdUOEl4WVR4b3gzMXFXRndzK1dTaXJQSHNhLzhnaHRsTzVmWlFNZ1UrUzdz?=
 =?utf-8?B?NTQxYWFvRFlXQlZnaktwY0thU09VeUhlNXVPRDArN3RwdURlSzdIOStEZzZB?=
 =?utf-8?B?SDFjTVo0cnhBTlJmMklFd2Y2QjQwaHRaYWlDSzRzTHhnamx0TmJFRUNENmZX?=
 =?utf-8?B?azY1UjkxUCtkd1ZrMFhEWlhUaHBVNTlHNjFLMzQ4Tndzd1VuTEM5NU5xODFN?=
 =?utf-8?B?aUFibkp5cXhqWTl1ZkhOVkJtUkdvUEgxZmRmaVJ6ZVlJMkJRSlIyMGcyQis4?=
 =?utf-8?B?NVRxcFN6dE5lS2c3dlNGVERLK05mUnFuOS9tRVVUUVFoSkpTK2l5UzRGZ3cw?=
 =?utf-8?B?WWJiOTZQRmJOanpQNFpZemhVK2g2MzJwdGN2aExFd0VUVzZjZ0xoYVNnRXFL?=
 =?utf-8?B?akZyUHE3UDgraVBEUzFXdks4VjljZnN1VDdBMTJvck1pSzFaZ2QwMmJJNmhL?=
 =?utf-8?B?MUYzWUVkcjFhTFgzRXNHeTNWMkhJbzlUd20zQ1FzR2g1Nk5UaU1kODN5Rmk4?=
 =?utf-8?B?RnlMa0lyNEJaRm1aaDRCWjdlZmV2MnpYZkZYMjFmMXZMSW80a1dmaFk1ejg4?=
 =?utf-8?B?RUVvL3BUUjk5SXJEa1JObjJ3cnRlQTZiYmlTVGNZcjNvK3V2Q3IwQm5zU3d4?=
 =?utf-8?B?UktOMys5UHhLakRodHYvTnRyUVowOURSSnpIUURwdnljODhPYUQ4eURKWDZD?=
 =?utf-8?B?ZXBFMWZ1Um9haHM5eWFvV0g2SlZQM2hRQU41TzRrb250YlBMcEdpZXpBQmN5?=
 =?utf-8?B?MTBuN2t5czNkN2RtMUZRRHo1c0tRSjZla3ZEQ2JXYnpEOTMwa1JiOTRqaVdp?=
 =?utf-8?B?R1pNWmZoaE9uTDNRTWFpZTFSemx0Y2M3Q1EvYVdXVHJ6Q3FwUmtKNWVITVhp?=
 =?utf-8?B?MFkwei9uZHk0cGV1SVE2Q2xPNjJPWUFMVUptcWZBbEFMKzJHSEtLa1pFZkxO?=
 =?utf-8?B?aFdDdmJYN0I3cWZ0Z2s4SkZIMzM1ZlprNll2U3VmQ3V2RXhWQXFVb3FpeG9K?=
 =?utf-8?B?VFlUUVlYcGZnZTU4enF2SSsvVVV6KzY2a1h1RW1jbjlBN0syVmJDbFV3M21G?=
 =?utf-8?B?Wjl4UGlPUXZ2NEdsM3grRFl5UWZTUEpnZ2ZHMHZDOU5hOGNiMWo1MnhDSjNh?=
 =?utf-8?B?NWxFemZma1FocTdvN2VPZ29IQXpNYW93d05oRThDcHVKZlhnU0pwWGk5Snlt?=
 =?utf-8?Q?pWz7X0TA9q3BHO6vva8iu4AgnokMKOU//zG80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW5JOS9ldnY1UEZybm91dEIyZXU2Y3ZBdWJiMGl3cTdnUWRJQTYxZnUyMldJ?=
 =?utf-8?B?OXlQdlMxUHBXQTJKNzhFK0xONS81eEFldXY1c1pMSWlEYk5tYkp0NW13c0hL?=
 =?utf-8?B?YnkyM3dGRVhpVWcwcnBUaVJOYzV0d1QyTzFPd3RDYWhhbjVvU0xlY1BVenFw?=
 =?utf-8?B?ckszNUxCRk0vSUtuZERoZUNheGl2WkdtZENDQUhKN0p6RGZjVnBtanFVZmt4?=
 =?utf-8?B?aUtScU81RU5VV0V2bjhOWFE3ZWxTbzZrNkRyMEtwckNzYVczQVlXakx5cXFr?=
 =?utf-8?B?RVpVRndEN0htVTVxNVZkdUFuWVVlZVhIVnZJdTR6R25JOEpLUU1BVzRDaVlZ?=
 =?utf-8?B?YXZESVJBNjh2VjlybkdvL1BvdVBhUVJUeGpWTXgxMFRIQU9tZkJpV3hIemsx?=
 =?utf-8?B?T2JTWDJCaTg2NzZOTHNiSTNQMmpnZHlDTkl5TzFYWXBjYndSS3NKamlyQi9X?=
 =?utf-8?B?UStMUHJpYmpJUUxybnVod2pGbWk2RnFhWUx4Zm9sRVR4RjIxa3hLb3lGVU1R?=
 =?utf-8?B?OU5EOUhYbGdIWHEzQkFuVHc2MTBCWUNVOUM0Q2lJbmFmck5vMjhiWlRqYnFt?=
 =?utf-8?B?TENFUG1GKzRlY1ZYaDhZY1J0MmFpTmdlVmZaMWdGNzV6YWQrYWZ2T1dldVRi?=
 =?utf-8?B?S09QbXBJbFNhcXBTVGFZTjhHRHBXQ01ySmpUeEpSWWJ0S3MvZThaa2ZRdzZp?=
 =?utf-8?B?dzNLRmtDbzFNZUFML0NkQ1dpSy9LWDVBYVpLZ2REUU9Qcy9haUZxM0g5TDFh?=
 =?utf-8?B?RDY1MHQ5d3NzMXJjT2VFcEs2d0p6MDJvbVJ4bWpsL2k2K0IwdUpxanZObWVB?=
 =?utf-8?B?TUYvS0xLNmRYc2tDZDdORjFIZm90UjB1MktNZVp2Y0pxQllwcHJLK01JYktF?=
 =?utf-8?B?V2VuY1FCcnZ4MnBYbWpmWUczanJ5THZpMlR4MVNyQXhnSUZKVUpJaEQzSW5s?=
 =?utf-8?B?R2UxbmV0NzlsREduV2VlMVNsZjY2VndqQVo0b0taV29NWXhGYmpEd0pnYkM2?=
 =?utf-8?B?Y3ByK0xLTU9kblBtN25wZzJYaVpweUdDVEpQSVY4eHJKUEpZa3pXcWFnY1pj?=
 =?utf-8?B?MzQrZ21KbDJpeGJEdWwrTHJudU1TWTlCT3dLbkx3b0lXTWo4NWo5VGdKSXB0?=
 =?utf-8?B?MzlhUUJtMWlWWi9LU3BHY2FLd3FmYlBPZ2JIV2U4RFExWEhiWWRWK0VoYVQ0?=
 =?utf-8?B?L2RnaHlwYzd1ZW1xemFQL3V3bitndW9qdUV5WEFIMlkzZ0d2RFlZNlluT3Vo?=
 =?utf-8?B?T255MDJ4TnVwMnJHRXh5MmlHWTFOcC9DNndDQzFRbVNtYUZIWFJlUnJESU1n?=
 =?utf-8?B?d0N5UjZUdXNZdVFSZk9yZ2tDYVM5Vm5UMGRHM2JSekFzeUZxTURMVFV5bTZV?=
 =?utf-8?B?b1lkVmtCVzhudnQweWQrWTVvVU5kdFJidi9XUlJLczdIS1dKLzdKQkpBVTZV?=
 =?utf-8?B?eWJqeXZGTi9HR2JjQjFkWGZZd0V6QnRieEFEN3l4V3NOb0VJbVE1MHBxM3p2?=
 =?utf-8?B?N2NKRDN3WlJ4b25YajRTK3lSWFBRRHh3ZXBvbkU2WjhqeDJ3Ym5MQUY3Z0I2?=
 =?utf-8?B?WlF5ZVVtZHA3YnBIUFo5Uk5udTZBcW5ndDNXVEhTaElmaEgxMmVON0psUWJB?=
 =?utf-8?B?VC9GYXh2a3BtQnlKZGZrTGg4V216RWRFcVBFS20yeUF5ZSt1WW5mMXRHVXUx?=
 =?utf-8?B?RE5uU0laTHdNZWRMWGpsbWZFUUZvSWsxMEgzVHlIN0ZsVm8vQ1hBTm5qVU0r?=
 =?utf-8?B?R2lENFhaT1F0blpxYURWK3hyeFhZVmQ1L3J6ZzdRalh2bkZJSTBYK1lCVWtx?=
 =?utf-8?B?Y0RVQm1TTWVGczB6N3FwQnZiTFk0ZjQ3VktjTkIwQkVrMjJuNHB2K2tIMlNp?=
 =?utf-8?B?RXNITFNPeGhSL2xsK1k3SzBoNEtISXJ0YTE0bUpNM01iVmhoazdBK1ozUnpT?=
 =?utf-8?B?WWVUMDM5TlhkbXNTSFJuVTNJRjdJU0NWKzdnaW9qOERvTDVVMDBwa2lTN3BV?=
 =?utf-8?B?OFJ6Q1NoeG85TWlkTVcrdFh2b2c5YjZ4dWxwMnhuWlppTDJsdWNYdko0bER3?=
 =?utf-8?B?MU00VDQzY0IzZzdkd1Y2WlpUaFM1Ri9XeWhPVTJPeGxSWjBxQjM4WFpRTHQw?=
 =?utf-8?Q?AhKDO7EasHp1CU0NE8He1Jm1b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6558ddc7-7bc5-447e-9c92-08dcd6530d35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 13:25:37.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th6/T2e16Ld6IugDZvzU4bngS65tsEvYMJe2jDGZuGb1/gyiJc3yJTA7XzxhZA49WbJO2SEzHIIOVMCmPxIiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430


On 9/13/24 18:43, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:26 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first stop for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be deferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c   |  2 +-
>>   drivers/cxl/mem.c         |  4 ++-
>>   include/linux/cxl/cxl.h   |  2 ++
>>   4 files changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 5f8418620b70..d4406cf3ed32 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> +#include <linux/delay.h>
>>   #include <linux/slab.h>
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>>   static int cxl_mem_major;
>>   static DEFINE_IDA(cxl_memdev_ida);
>>   
>> +static unsigned short endpoint_ready_timeout = HZ;
>> +
>>   static void cxl_memdev_release(struct device *dev)
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver.
>> + */
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	unsigned long timeout;
>> +	int rc = -ENXIO;
>> +
>> +	/*
>> +	 * A memdev creation triggers ports creation through the kernel
>> +	 * device object model. An endpoint port could not be created yet
>> +	 * but coming. Wait here for a gentle space of time for ensuring
>> +	 * and endpoint port not there is due to some error and not because
>> +	 * the race described.
>> +	 *
>> +	 * Note this is a similar case this function is implemented for, but
>> +	 * instead of the race with the root port, this is against its own
>> +	 * endpoint port.
> This dance is nasty and there is no real guarantee it will even help.


With all due respect, we know Dan's dancing credentials. Which are 
yours?  ... :-)


So, I found this when testing. The driver calls devm_cxl_add_memdev and 
then cxl_acquire_endpoint, and the endpoint is not there yet.

Interestingly, I did not suffer it initially, so I do not know what 
makes it trigger, but I have just tested it again and if I remove the 
iteration with the timeout, the calls fails (it seems it does 
deterministically). This is with a testing/developing VM with no other 
main processing at the time of driver binding, and with 8 cores 
available. Of course, if the driver does the second call without 
interruption, it is unlikely another core can handle the bus 
notification and create the endpoint faster. But I wonder why this is 
(was) not always happening.

I agree the timeout could not be enough in some situations. I think it 
all depends on when bus_notify is invoked, but I have not dug deeper.


>
> We need a better solution. I'm not quite sure on what it is though.
>
> Is there any precedence for similar 'wait a bit and hope'
> in the kernel?


You put it in a way that makes me miserable ... but maybe you are right, 
since there is no certainty it will be done after the timeout, but it is 
a full second ...

I will dig a bit ...

Thanks


>
>> +	 */
>> +	timeout = jiffies + endpoint_ready_timeout;
>> +	do {
>> +		device_lock(&cxlmd->dev);
>> +		endpoint = cxlmd->endpoint;
>> +		if (endpoint)
>> +			break;
>> +		device_unlock(&cxlmd->dev);
>> +		if (msleep_interruptible(100)) {
>> +			device_lock(&cxlmd->dev);
>> +			break;
>> +		}
>> +	} while (!time_after(jiffies, timeout));
>> +
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 39b20ddd0296..ca2c993faa9c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>   		 */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 5c7ad230bccb..56fd7a100c2f 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index fc0859f841dc..7e4580fb8659 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>   #endif

