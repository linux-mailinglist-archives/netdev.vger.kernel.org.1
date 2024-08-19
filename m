Return-Path: <netdev+bounces-119804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B560957041
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56F51C208CF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41217557E;
	Mon, 19 Aug 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rL8uxk36"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE2175D38;
	Mon, 19 Aug 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084975; cv=fail; b=FkNjlIft6VjoIvPlO5iz5fOd72YigbPXXLbaByWAakSUUUIJGRPMG/yaZfRwm58E44Qpv18J2VMNYoiRtBNq/RVqwjeIKP4H6f4nae9Af4WtDP/ISBqGef7Vesn/IBWqsx8xGEjou6Uf/aCvFJReVmCOzFAqyDF51KxB3pivaeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084975; c=relaxed/simple;
	bh=Y6+Mx+MZEMdXnYMgCdAmfpk/euwNkrLJVXjJPL8NKP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sNr1jsEMDt/qv7e4G25PnB64Ozc/zjj78oGJiXPoXsD52VjNMG17NDeQGDuQeboc7KzAi84XC4zk86VeaJqn++W9xkY/TJpTTY22TKCkmAhT/NOiafYTzzJT5VCdDGZlZHfW2g6eXuKUDF3fPZ4Noxm28VEzkAs/029MBrTmD8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rL8uxk36; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3CNMmCTO0GygzujR5izPil4Invm84u7yArsHoIC+QIuj7HLELfqt2/3cMvzaNh5n1fYxsyqrsqFkiOFXfmqN00HRAFsahtUKG2oSIjTPAnxBbBJjZDcp6t8qtrIfqObOjaTUd2LJ14Beg1KF2j/TVmQuhazd/gOVOlsg5me2rWHpejeR+azg37sTCDkekwSGkokA/quYTU0U8Wituc81h9CPrRK0U2nzMK9HiqJ5VwQdtTRaJk/i2NwhcRap+z1INugiXLMAS98bIWVEvG/fj+2/u8G8br2HTJvO8fa0sfYgFrprJRJMTHUYJJ+clo/8OJWKepS9IIlkInzFlwb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMLwVQm7l06ZM0hH5bN0FUrUsjKU47VULrbbjYO/wrs=;
 b=UiK84KVTe7G3IyrGFn/B4ro/36vov7c3Bc/XTy3fbcRhmRrsaRmayasg4na6qptfret/OnLFM31pBI5Vuwvj1FjQINPwClswmRyi4leIIsUbzMgCKPFIUbk2BBjWPrz6CWBuRiYR+7139bFC4XqN0yGeZOcWaBpPBVPpapUdkIzQUD4ZfybDuke4SlxrKDYU0zUMaqb38lWkJeE7YlEDlWgx7vJ8gLe67G/CAcVDk6ijHD4LXaYI12XV3sIQJF03NuYm/7+V7aT0au3lptqyRBhOL5GIXQtdiKIBS4qVHbd2gHaSjjvFFpV4ZQWxgKq8wpCB+q13Ph+pE+572znR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMLwVQm7l06ZM0hH5bN0FUrUsjKU47VULrbbjYO/wrs=;
 b=rL8uxk36lGV7n7quiNRtVE7O2ywg4PJUI/uIbyNTyi5Hpvx/BcDTuIFGxDU8zmDudx8O7o5L6vMQyah2zgXcHC9LNgMrm1E/RZZR+wOZYsNpNXw98SkMOiUGVCVTDAM2AAp4shxej0BWyzvIilgc27/y+KITOLHwCs5wz9CVIV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 16:29:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:29:30 +0000
Message-ID: <7e17a0f9-ef84-5ce1-3574-5d609525b7f1@amd.com>
Date: Mon, 19 Aug 2024 17:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 15/15] efx: support pio mapping based on cxl
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-16-alejandro.lucero-palau@amd.com>
 <20240804191339.00001eb9@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804191339.00001eb9@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::32) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcacf91-ebae-4f38-a805-08dcc06c19c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWs1TnBReWREbkY5OUJ3d3l4dTFTVmd6eTFMNUJXVm9zWHhsTkJTelRud01R?=
 =?utf-8?B?eERiNHg1dFJPdXl4d25vWGN6TTdUYnROeDhqbzIxcC9PMkdwRDN1RllVVk5G?=
 =?utf-8?B?bkxKNWhqeGZILzN3VlJBbmFBc2FHOXRuTU5ZV3E1ZUJjbjM0NTl3QnVkem9o?=
 =?utf-8?B?NkRLTUNDMHV2VkpWVjVxK2NiNDRiR3hjTnNFRTlmOUxXTUtuUjArVHUyQlBP?=
 =?utf-8?B?SGw5MDJHS0hZWnd2enFTa3RtS2s2cUVpK2tSaEJMQXhEeEFYUXFmK25tYzRK?=
 =?utf-8?B?NkE2citEWG1IQTRiN2F3b09kckV5RjlWNTk5eWlvdHFMRDdwdy9UZnl2S3hr?=
 =?utf-8?B?VUtEN1k1NGpKK0JJRTBVVzZGQkEzZjFKZWpveExZb2NqVFFVL29aVTRkOTZ5?=
 =?utf-8?B?c3ZSeldvZ0ZrZ0lPQkoyYlB0QmFqRTZiQ0dtVi8vU1ZEVDZoT2tRcjlKTVRj?=
 =?utf-8?B?R3lFUGIyR0tWMmF3bEo2WXpGRVRNaWQySXYxbnZBRE1udGhQQ25CNEZ1eHMr?=
 =?utf-8?B?aFRodzBUUERCeTZ2OXdZN1hOOWJFYU5PTlU0NjBaMmFYU0NnVDY5bmN6L0li?=
 =?utf-8?B?cVdNRHhGUDRxNlljR0E4ZXRtWlpyYllsWWorNkE2eHRwaVpwSlVWQTlVaVBX?=
 =?utf-8?B?V1VVYTB6dFBxTU5Zd0JKNjJ4ZzllSDBJRTFBNnR6RDJIN0xWTDNzNEVmcWxE?=
 =?utf-8?B?cVdDdEpjdHBFSk5PendKZEdaMVdOTEIwYSszdGdEY1FBM25sNnFld0hzak9O?=
 =?utf-8?B?aVNwOS9HanZYL0FPK1hFRHU4OFZVU2tBeGRwM1lUaFAvV2FpZUhJcjF0dVpU?=
 =?utf-8?B?d0c4aGZLVEVGVTQxSkFERmNNT2RNRExOVGM5YVZjZlh6akxDeGRNWkhjNWsx?=
 =?utf-8?B?OVNWYm11V3Zpc1RuOGw4RUxmUld3TlUwTmgxM3lCS1RXSUtWdkZqSTJvVTR0?=
 =?utf-8?B?aVJRTXc0Yk1raEU3SzN1NHFLeTVMWmUweGhrcEZraldJL1FrcE1zRDd6Vksx?=
 =?utf-8?B?VFFkaVZZQVJuOXFSck9YSlpsdmZWM3hlZE1aUGNnVGYyUy8vbGJ3UUJPeUpw?=
 =?utf-8?B?MjVRdXVMRks1OGZuRDE2aEtoNkMvVTFURERGYk8rY3dEY05RQTF3SDJBVjN6?=
 =?utf-8?B?VWZ3M1M3eTkya0s3aWd0ZnU1WTdweTNMUWsrQUpOdHJIN2gvT0UvTUtGSWI3?=
 =?utf-8?B?cWZIOHo4NkFYa282YmVTUkQ4NHVCck9yNm8yY3UxK2l6TC9qNC95NXJjL0Ey?=
 =?utf-8?B?eUxCNHE4ejVFaThsbTF3cjJLS3B6elA2NmszYTVvZ3NGc21hNndrZk1TYTBS?=
 =?utf-8?B?QzNyWGFrQldjSy9KaTd5RXdwRnM4S29NNHB1cTU5QWZWcVhxbHQ0cElLUWg2?=
 =?utf-8?B?bytJM2xmNC9PWDZuUDI0U09lYkRiWnVxeU9JTlpsRWFObVowTk9kdG41d1lk?=
 =?utf-8?B?WkU2RE1uZzNiemx4MnFWb2kvelBUWWdFWGtMU09rNi94ZGgyY0lQbFNQZWdU?=
 =?utf-8?B?clUvU0pCcDdxV05IREVOQ2Q3QWZRRzIycElKY3pzbnlBSVpLcGlvbHRqM2lE?=
 =?utf-8?B?K2FveVNRNEhDb0xYY0dUOXBtQUpkSTM3V0hQcEM2VVh4RWN1aC9tSUNSRytl?=
 =?utf-8?B?ZkhxNmNhS2RxVXZjdkFKNlJlT2NmT3RFaDZJcVdUSEhUZExPblRUakZZOENp?=
 =?utf-8?B?SE1rSitHUUx0US81ck5lZ0hoWDlWS2pkN0szVjJsR0xCOXRRZ3huQTFKeGVK?=
 =?utf-8?B?WDZVSGRDM0J6ZE9vS2k1SHIwaG1Uam5jK0Vkeng3WjVQTlFXZ1JBR1VGY2c1?=
 =?utf-8?B?RE8yU282QitETzVSanVndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXY1M1NOY0xPZEF5S0tRYmgrTmNyVk52dTBHeEpkeldqZW1GUHJrSHF6VDls?=
 =?utf-8?B?WG5Uay92c1NrWDRSMHBMOW5UT015Sm1tVmtPc1BDNk42NHpTNjNPTlpaaVBk?=
 =?utf-8?B?QlJLbXhzdWw0cFNkWldxdjh1UWpSMDY2UTZoSzNPSjE0S1U2eUV3NUYxVGRs?=
 =?utf-8?B?Y3NDM3VQM25nRGJGeldWMTVqNk42bzV6akQvcHFjeFQ1S0hWWHExNFBYQXRq?=
 =?utf-8?B?cmU2VHBYOFVCcnpQcWpIQ0pQeXZkaUl1WUZ2RDQyUXkweXVPaHlHNXZ4SWx0?=
 =?utf-8?B?bEZYRDRXSk80NkprL0l3L3NaVnJRbFNyV00rOEJ5WWNTMnZjcnhrRlp0dDFm?=
 =?utf-8?B?R3dWV3dIUVdHZzd0UnhyUjIxRkxoWGFLRTdVUzNWOWhyY3NUWEhBS2RiZXVn?=
 =?utf-8?B?NTBDQjBhZG92bUhkWll2VURXZklDc0RiSVF6d2NUQUtDcTBjMHJON2x6YWlL?=
 =?utf-8?B?ZHRraTBEQjFvSHppYzB1QXRVNzdlekNEekdiV2VSUnZTdlpYTnZyNUgzSVor?=
 =?utf-8?B?d3NSYkhUbFpVWTJubmJHNlZBeXQwazh6ek9lYW5KQlR2S0ZvaUFyNWh2UTU5?=
 =?utf-8?B?Y29RL3AyVGZpT0dnRlJzRmpIbjNlajNkcEp1c0F5dERMTkdMWG5RUE5BcHhw?=
 =?utf-8?B?WGNNNFpsbDBKZmVQZ1lnZXRpai8rNHp5UkFqV0lhbmZiVHU4b29wOVIxRXk0?=
 =?utf-8?B?MDhDWTMzbGlZaWc3OStvQzFuNTVGSlhVWTFpWlVEL0ZwRy8yL2FtdnRMNUtv?=
 =?utf-8?B?dEdJNy80Y0UrTkRCTUlSNUszeTl4aVdjN2JkTjJvcEw1bHdHVHREbWJscEFr?=
 =?utf-8?B?RjlmL0pUZktiT1BGWU1MdG85dXpyUU9wbU1IZTJwYnJzQ1BkZ2o0dlk2clQ4?=
 =?utf-8?B?QmRXNGQ2UDBzblJhM0NuYzRvUVplZ1BPY1pHdGQ3UkQrYk9aZ3czTzZ2WFc4?=
 =?utf-8?B?VHV3d2plZGZwejlHcHdGZGJEL1Y5RGgrNTNTVjdVTEJ6ZDBBSmhCOGtNeEdm?=
 =?utf-8?B?aXc3K0Z1WEQ1SzVrTlJYVGpkN1RHdGFqM1p4QkdnamhaWDNmOHpQWUM1VUZh?=
 =?utf-8?B?c1NWR3o5SlJYazYzc1FUT2YxQnlBR3JUc2dOVkx2UGJxUTlJUnZHR2NDdlZw?=
 =?utf-8?B?N2NKTkFnNGFpRm5tdWJzVXJ5Wmw3TE14YTJQdW5XaXkzbzlLTzlmbjVQa2Fq?=
 =?utf-8?B?VWRBWlJMeFRhWUkyNk43TGJCVHR1d3RSQTVhN01Xc3o4N0tFeXoyNGFCZVN6?=
 =?utf-8?B?cVJCS2Rzak9FSkg4UTdIc1QxeFFUb3ZZU3gyaXpqNmN1Syt3R0dySEExclRY?=
 =?utf-8?B?V0xETnRSYlphWUFUdEFEWWZFa0k0OHR5Ni9IK2RKcG1qU2dpQWpFQ25DQ2F5?=
 =?utf-8?B?aUp4Z0ZuRHpySjE5TXBkMFQ3ZmRBTWhDSFkyL3FIL2tWbytoOVJmNkd5Y2NV?=
 =?utf-8?B?REpmeW5YRUFYZTQvbklXbG1xNE1VMEluVjNlU0ZFYnVFREQ3VDdWdHdub1VB?=
 =?utf-8?B?ZElsRTBoL3JnVG1ZTlNiT0p3NVBFL2hUZ1BubTcwb3hFckNnYUFSeTFuMGw4?=
 =?utf-8?B?WTU3dU9DbjZibWZWL01uYXpJMGRRd1B5WTRNZlFYZnlSREdXbTZ6dUdRcmJR?=
 =?utf-8?B?ZUkyQzdtS3dKOUwyblFzNWlHSFU5L2V0M0tGWlhVUEQ2VlpEVWJkOWpZektR?=
 =?utf-8?B?S2pNUkRVQ3lleGd4SW80Q2V3bWxPSTlybmJEaFBLeTZUdkZ5Rk1NckZES2lW?=
 =?utf-8?B?d3QyZk1wM2R2ejEyRmVYUlZvUlZNVmtSOEdNR2VsRWtMMnVkKzhsU3Z0Qlk4?=
 =?utf-8?B?V2FZcC9HZ1dQNDVmbVhhTWsrTDNWVW50TGJuYWcrcllTN0hGd1JEWWZLUGF2?=
 =?utf-8?B?T2h4NGJJdWpMbmVyZGViQ0IxcEdBTjBjbldTV2NBRit3ZWp5b0JvUEsvZmpI?=
 =?utf-8?B?MTBoQWxCWFN2aXN1UHZkRGVPQkErYW91YUpTZXg5aytRQ1BhV2ZQRzV5RVlZ?=
 =?utf-8?B?KzQyRzBqcUo1U1pMZlNuQ25MSkVVZ2dxOFdaVGRFdWpYTlgvS0xPd1FjTExl?=
 =?utf-8?B?cS9Mb1M5NEVDVmFFWUR4WnVtcG03Y2ZtRzRGYlhzYTBvbUZkSDFIdkJQa1Yv?=
 =?utf-8?Q?LUaIduKBrINu6AZTywhbsXlop?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcacf91-ebae-4f38-a805-08dcc06c19c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:29:30.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WQrVGsOuQwKieCO6y2BHK2+F3Sdrr85M5MnQDoKGhxTFvYr3aWQ40WEXftwz24L6/ks3S//F0I/Cg5rqS1DXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889


On 8/4/24 19:13, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:35 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
> This explains why you weren't worried about any step of the CXL
> code failing and why that wasn't a 'bug' as such.
>
> I'd argue that you should still have the cxl intialization return
> an error code and cleanup any state it if hits an error.


Ideally, but with devm* being used, this is not easy to do if the error 
is not fatal.


> Then the top level driver can of course elect to use an alternative
> path given that failure.  Logically it belongs there rather than relying
> on a buffer being mapped or not.
>

Same driver needs to support same functionality which relies on those 
specific hardware buffers.

The functionality is expected to be there with or without CXL. If the 
hardware has no CXL, the system or the device, the functionality will be 
there with legacy PCIe BAR regions. The green light for CXL use comes 
from two sources: the firmware and the kernel. Both need to give the 
thumbs up. If not, legacy PCIe BAR regions will be used.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/ef10.c      | 25 +++++++++++++++++++++----
>>   drivers/net/ethernet/sfc/efx_cxl.c   | 12 +++++++++++-
>>   drivers/net/ethernet/sfc/mcdi_pcol.h |  3 +++
>>   drivers/net/ethernet/sfc/nic.h       |  1 +
>>   4 files changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index 8fa6c0e9195b..3924076d2628 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <net/udp_tunnel.h>
>> +#include "efx_cxl.h"
>>   
>>   /* Hardware control for EF10 architecture including 'Huntington'. */
>>   
>> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>>   			  efx->num_mac_stats);
>>   	}
>>   
>> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
>> +		nic_data->datapath_caps3 = 0;
>> +	else
>> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
>> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1275,10 +1282,20 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>   			return -ENOMEM;
>>   		}
>>   		nic_data->pio_write_vi_base = pio_write_vi_base;
>> -		nic_data->pio_write_base =
>> -			nic_data->wc_membase +
>> -			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>> -			 uc_mem_map_size);
>> +
>> +		if ((nic_data->datapath_caps3 &
>> +		    (1 << MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN)) &&
>> +		    efx->cxl->ctpio_cxl)
> As per comment at the top, I'd prefer to see some clean handling of the an
> error passed up to the caller of the cxl init that then sets a flag that
> we can clearly see is all about whether we have CXL or not.
>
> Using this buffer mapping is a it too much of a detail in my opinion.


Yes, maybe that is clearer than relying on the pointer from the CXL 
mapping.

I will do it.

Thanks!


>> +		{
>> +			nic_data->pio_write_base =
>> +				efx->cxl->ctpio_cxl +
>> +				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>> +				 uc_mem_map_size);
>> +		} else {
>> +			nic_data->pio_write_base =nic_data->wc_membase +
>> +				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>> +				 uc_mem_map_size);
>> +		}
>

