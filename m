Return-Path: <netdev+bounces-189712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5CAB3508
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED726189FFEF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30F267393;
	Mon, 12 May 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LqQPDMiV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B479254AF3;
	Mon, 12 May 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046291; cv=fail; b=B0/aNNXCfa2j3sBt4aYwcxmH7aE15BbmWGm8liAPqF9G58NS+xU8EHcF6EUG0Vr9nHIbspGSOsFf3Ue493Tbm4PRCeAe9kxwB6HtwzAbfmozaljn5Cb3108QCvFHnnopl/i3FEP6dZZ1PE2Hw6Se66mgPGOyC0AnluyOZQJKnJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046291; c=relaxed/simple;
	bh=tT0GfeLmG+/GwUiQ+mEA49+Gad2vLfVhZpDvQeIG2rI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zt7d3PGsJpG7LSeUd/QglRooMTd7gvBe3lJ4m0+rb9SC96Erw3/Z5IM08WNT1KZkb2qGrxou5F8QqgPwIn+gz43QeGNk5w4UKatb2+pshKq9KUF3A7KYRJGmB8XH68xCw8gQuyGlF8av4dyMOnQCtQXa6UbEsv5+NtQ2XLNrXhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LqQPDMiV; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r32Og9ygvPDH0+neAIlkWl3YftknF7fihm6ZFJ9HCvEANDIPpPJGS+XewWQkDCcg76oZz60z/w6clgI3BVmD5DfVuLK9y7uBu/DFpdQTsdipXctADSCliSPfFAZx/znb7zUaMTT+wY57UrRa89IIme8YFiIlWHy5sz4kJGTjIZvBvSrqaRvC94qcEF/8I4GrKm06diUaMv/Sq7Yi67mnh6hbpWrGMdE9MLrFW43QH0Fij5aGQFqW/REvO6JweOURmeGu65klsTz5SLREWxW44ZoLY3pGSX6gXsjAm8v9x9pHL3Nv+e04oIv3Drg41P/v4EPsXj6348ddWYAcYML+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxML0DhBor0zS7lBwV8ofxhWmvpjbwODcYZqz+nUhxc=;
 b=S5T+XBBOZzmO4EZE/kXvo/jRdMipQbGD3MP3NMO39ruQsN7rwAB9hKUnZov32H3QdTHJORJ1TqUI80diVyIq/0L6DQa5gtWjZ4r0bTfq8VCuMRooNWxNcs2WikoKKs3uItkqdeWfvJmOdq1N7x5OeTX5KOFZGJbk1exrcOh4bv9tVMkm7oagWTichClBMmpHIhcSWOiyjdCi5Iw+ntdLZeSeNUE6wTEXxdQoYlWLLW0wJ0X41N+VKw3Xd6Z/1Aw00MOmsCDxRejhWTVoMEiu4153h6oZIwu4/AceOVx7vKSjFKIuppCHrwCHkFuwoH14mITuiPGnww+zE1X33LygpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxML0DhBor0zS7lBwV8ofxhWmvpjbwODcYZqz+nUhxc=;
 b=LqQPDMiVTYmDilEClO8g6BVJZ7te3RmCrJhMm5rBlZXRoVTjMHbAjIrgWKRK9BaZU2We1KViJmlULhrNG3+cCrkfcw6VmdSHoN6OrKVHp7Jnrxxgn+N3wDaaEExf+jPWUOC9rADnuDNec5kFIey2VG3lqabH9cQVM8Sy6hXontE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 12 May
 2025 10:38:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:38:05 +0000
Message-ID: <9a37931d-0e40-4b46-bf2d-93b6c98aa2fd@amd.com>
Date: Mon, 12 May 2025 11:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/22] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-10-alejandro.lucero-palau@amd.com>
 <aBwDkBCw5k-6NksY@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBwDkBCw5k-6NksY@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa4309e-7cda-4ee2-98b6-08dd914113f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFxTEpJSnRHVUp2OXpxR3N4K0U4Uk9ndVovekFxME94NWFkd1lXbk9xWHdP?=
 =?utf-8?B?R0dIMVlnYUVxR04xclJDRzhMWE9XWVB3Njl1SEhyY01CcDlBVEJQZG4wNzFP?=
 =?utf-8?B?VlJnT1JaT2VOUzlwVnh1VmhuOE1iekFVM2ViZy84UGJQMnhERUc1THZMblpo?=
 =?utf-8?B?eHprcWd6OUVrbFRpclZtRkxBalBqK3N6bElXaTZGZkgyU2pmdHlNN2hLOWFw?=
 =?utf-8?B?Q1QxZHBadEd4eVIwdDdHaW52TTU4dW50REltQnArUS93clZDaFlTK244dmVt?=
 =?utf-8?B?bE4rWVM5SEZ6cWdzZ2JOcXc4emRGVXBucmNRZ2E3dkhuUFlWbTM0TjJtTXd0?=
 =?utf-8?B?YVZ3RnFFdXVWLzRyb3pSUnFPaHlOaXFsQkVjZ3gwdVBtUXlQUm53NEttQXZE?=
 =?utf-8?B?Ulh3ZUxpY0NKVmdNeUdGMjQ3OFg5ZmJwc0IxOVpFbjZVZjFBTFJlcG9meGor?=
 =?utf-8?B?azhpUUt2TjhlelhNdU16NVc2YWtOMEJGeG1Obmh3TEJUQnR5K1NUUXJnd0lD?=
 =?utf-8?B?VHZGYnk0MU5ML25ONExzdTgwQVYyekw2WVowaFNyVmttc0RRbVJiR3BjVXo4?=
 =?utf-8?B?aG1SYThMOFJ4a0FZZzZKcHk5dFpqQmFqNWgyMGZvdEtlZWN3aG1BSXlIcmEr?=
 =?utf-8?B?cWVOVHloV2RCRllDU1phVFZTMFRTNGVyQWZUTjhiUHhNN2t1dEpQcGMrVmtU?=
 =?utf-8?B?bDFiby83MEJsZEtHOFFvUE9UTHZDUnY0Yk0yd1NoZGFTQW5TOWNpUTZnTUp4?=
 =?utf-8?B?UUMrWkhXOGRTd2I5ZlBTRER6S1pNV2ZSR3Y2MkM4cEZidnJwYUdobURrSGJC?=
 =?utf-8?B?bDJZMXNnQVlvV1dlY3I1SEF0Q3lhT0dVMkVJdzdwalRLTVh1T0ZVaFg3c3o0?=
 =?utf-8?B?RHkrc3h5ck1qU3Nhcnl5eHlCazFUd3V4aUh4QkQ5MzRPN21vK3JVY283Ujdo?=
 =?utf-8?B?MU00WnpJZDgvVG4vcGl0SEZYVmNHTk1GdC9XeUl3ZkxKVmdWTGprMzdwbkRV?=
 =?utf-8?B?MEZEWmpVc3N0YXJaZFljaFdRVC8wbFdGTmIrL21HWEZ5dEp3ekg3R1AzNzg0?=
 =?utf-8?B?ZGxjdUl2K3BLNUNMUS8rbVVMWG5QQWFuUjBDTUN2VXROZmJJQVVIaGt4U1I5?=
 =?utf-8?B?ckNVWWROWTZKd2J4YWwxY1p2QnE1dDhVRGRIbzJCRkVBWHhUTlNtcnhYVVpS?=
 =?utf-8?B?cUNoNHpTelZ1VS9jQm5ORExBajNQQU15d0pGbklPNWhaUk8zb0E3ZHpTd3Np?=
 =?utf-8?B?YlBFeFRqcjVsRE4vMUdWRVpSbjJQSEVPMWFQU2tCTmd6K3o0NHFzYk04Zndy?=
 =?utf-8?B?Y0J4aHVhY3hDTWw1Ymp4T3dtSEx5bUJXY25GdzNIRWp1VUN6dnE5VmVWOVh3?=
 =?utf-8?B?T2UrTzJPanNjOWQwRWs3YVViTkxwS1FRK1RzNzFrc1BKZDhKaERrWkRaNkh6?=
 =?utf-8?B?Nmx6YWJZcjd1Ym1kYVNPRjJYQ1NCMm82cUVrTVc4RThIdUJXa0tWaytiSVhO?=
 =?utf-8?B?QWZnY2xSUDhkYXlKcG10VDFoOUNWa1N6bVFQUFBsNTE4Y3hrRC9zdnB0NkVQ?=
 =?utf-8?B?MjBDZlMyOGVYSG4rNnBBU0hIRXZpZTIrTG1DNmc1VFE5T2xrb2lwZTdoRm9s?=
 =?utf-8?B?ekdMRXY1WWgzaEZYYTlkNEJKbS9VdWl6OTVYSTVXYlpMcGh2VHF1ZURGeHBa?=
 =?utf-8?B?cjBBMHlsVlJ6UFRJaTB1TnJNejZJTlZZSTFhSlo2ZEd0TFNRdURQZzBZbGF0?=
 =?utf-8?B?WFN4c0lxQ2NDaWZRMzk2VUZSYU5UUEtoOVNsQzZXcWhTdkRQMDRTd0FtWmRI?=
 =?utf-8?B?VWJjc3hYYnlaT25nQmlCMG94WnM0R2JTQit0Kyt1cVprOXNXQWpjcUY4KzFK?=
 =?utf-8?B?ZWRqS0E4RG1qS2hYOHA1T3lEVlRtSCtZK2t3NUk3WXdnRlpEeDd4NnZIeGF6?=
 =?utf-8?Q?QMOIt02oKt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZMZ01IanBtaUgwazRSOW9BRlVvZ3lwS253RUlMcDd6SVFIQU9sOXlqcHNi?=
 =?utf-8?B?ejlFb3laQWpqenBpdm9hOTRqTkpTL0twTjlHSWE3T1NnRXc5bkdPaU0ydnFw?=
 =?utf-8?B?RSt6NExiTUdkNWhXTlo4emxjMmw5elhpald6d0JKQVBvdUR5cDVjY0NEWGIw?=
 =?utf-8?B?SEhWQ1hjUGlsNmZJdnUxMVROUEppSHNqRmNRWU0yOVlhODhDZndGN09SQVVP?=
 =?utf-8?B?OHEwcDhYY0prcnE5RUxSSTNOUXZ1eWFEbElYTGpzUEplVmtsYWd0d1JDOHNz?=
 =?utf-8?B?alZ0bStnMVYvTzVTdEdzQkI3QzVLZ01JNE5pWW12VmQ2eElKd1EvTFJXWTI5?=
 =?utf-8?B?R3RiUmZXRG9MQm52Z2I5RXhJVUgxRDlmcmlGaWlUZ3ZnbldCK3lYREMrVkk5?=
 =?utf-8?B?WXV6ekp6ZnAxR2xCdHluQVBqcVNaRmphSnlVa2xjcHYzU0N0NXRuL0VmM1Z1?=
 =?utf-8?B?Q0FIbFo5bTAxSnlkL2JYMmFCVzV5TjZqWmppM1lQL0N0QlhhU3gzd01LYkl6?=
 =?utf-8?B?c1JLWE9aOUhWMFJOZ3VZZFpxU1ovRDFDa1ZHTFhIMTlFWmVCLzlTU3IxQVh6?=
 =?utf-8?B?ZTVDNXZ0bnQ3U2FaNlIvU2loZFZFdk1YWEV0dFZab1NXWXJqbDhOQzZWODJj?=
 =?utf-8?B?UURsRDRHN3NUdUZhbVpxaDVSL3FOekJkUE9tUHZrbkN1NVlsOGhZaWZBdWNW?=
 =?utf-8?B?emxnT1JDbnR1ZDJIZTFRV29UR0NTSlVyNjhuWHg4V1NyMmIveG9pcjBCanRo?=
 =?utf-8?B?S3lIdDhsdkY0WmloWktRU3BuRE1ZSExHNkNwQ01CNUMvTFh3YXBsbG9BMmNL?=
 =?utf-8?B?L01XbEpNbmI1Y0dDSDFnTjRadm82NGpJblptaTE0c3RBNjUrS0xHMmU4R04z?=
 =?utf-8?B?TTN2bmRBMndIaGNKRkdLelFhNWVadllhUjBadlNqaDFvd0JVajdiNHNZSWJG?=
 =?utf-8?B?OHNETWRZZCsvYk11bnFnd2FJZWJSbUlUbEFCYTRvcnRwVmRFMVdHYk1Cc0hY?=
 =?utf-8?B?SVFqOHh2dXFmZ2t5a3lFcnJpRi94ak1Ua0NBVkxSVWxXZkNvQ0N0L3VvYW5u?=
 =?utf-8?B?WHNvZ3REc1cxb2RNZmdhNW1lQThSZC9ma3NYWlN1WllTcFVRYytXNWp5YmlU?=
 =?utf-8?B?cFdBOS95R2YraTFOTDV4UUkyak5lc1gwQUtJQ1ZqVHc3cHUrNzdhdGJhVXpl?=
 =?utf-8?B?N1BrWk14dklvSU8rQnRsbC9UK0l0d1g5U2h4ZnUxeVlDTGdzVlZYZHUzaEVN?=
 =?utf-8?B?NkdNRE1pQXlyWEhyeWxhRk1rUzIzTUZOSUJ6Mm5Jclp4V1grcHAyUDRtMW5U?=
 =?utf-8?B?U2pKSEVBSVA3ZE9OY2w3R2k1NTZLUlZsNDJqVTV3dmVESHdzQnlpdnR4UllM?=
 =?utf-8?B?RGZkNTFPeG1obytzSS82WElQVEc5SkZzWTBSYVYzSEtPS2RNcWYwMWtObTBM?=
 =?utf-8?B?dGdReWx3V2JSTCs5QkZXU2JuUTByODN5d2RnNmRPa2hBMWpkd1BidVU3MHA2?=
 =?utf-8?B?Rlp3MkpaL0NBM3VIWllnb0NMMFc4VHlna0RYdndpNEdHVm1SWDBpZmtJWVZy?=
 =?utf-8?B?QXFLRXBuSVRGbDdER3VTMEhOVDdya1poWEtZVXRycUxyQmxRRFc5VmJMdUxk?=
 =?utf-8?B?L2ZEeENpYXdMUU1UYzM1SHRkVTE3TFhwWW5aYm5FNHAvZlVCam42UERhZnJu?=
 =?utf-8?B?ZHd4b0J6WXFhU1FPbHJOVHNKT01DMCs1SUc5TDBnc2VpQS96NWllT3pzVmky?=
 =?utf-8?B?WWVTWWMyUitKNW1mZzFhaldHNnMvdTMweFlWbmhkTUJSVDgzSkpLVmxHV083?=
 =?utf-8?B?ZTdSZTBSM3RDWDBOS3dTNzhFOGwvZ250cVl0Mmp4c05oTmp2Z0ZDQ2RjQjFQ?=
 =?utf-8?B?a1g4OG1pQXpDT2NQRlUyMjNRZHhqMVplZEp6ejIzMVVic3hndzJWNm1LcEZT?=
 =?utf-8?B?amcvLzRMU0FQamFlT1lPc0tXdlRxWEVNcTJvU21veEFQQUdkbjBpZ0pUOGty?=
 =?utf-8?B?S0VyUS9uNVV1TExZYWZkaEFqK0NWekppVW1MZnA1emM1WUJ5eUlPVm9FVnFJ?=
 =?utf-8?B?VlZ4VzR5N1g2RHpLeHlkRlBxekE0RUlnd25MWXhCemIzTExrWFFtcFVrNU1Q?=
 =?utf-8?Q?34/DrgivSDYWk+Y6JF9cAyUl1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa4309e-7cda-4ee2-98b6-08dd914113f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:38:05.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21ZHHdoqpa6jcwcVuT4QLVddBh/V8HdR0mDUfPB4aF5jiXAcwTY2mgIM/FBsrWMfoMnzO8r9NBP80tZGgmlGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723


On 5/8/25 02:06, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:12PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type.
>>
>> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
>> support.
>>
>> Make devm_cxl_add_memdev accessible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>


snip


>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
>> +
> The above 2 'if (!mds)' seem like indirect methods to avoid Type 2
> devices. How about:
>
> 	/* Type 2, CXL_DEVTYPE_DEVMEM, excluded from poison setup */
> 	if (cxlds->type == CXL_DEVTYPE_CLASSMEM) {
>

Hi Allison,


I forgot this one.


I think it is better to leave the current check because it makes 
explicit the problem of cxl_memdev_state being null for Type2.


Thanks

>
> snip
>

