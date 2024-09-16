Return-Path: <netdev+bounces-128571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CE97A5EF
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857A61C2292F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3F156F55;
	Mon, 16 Sep 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pbx8JcnU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F914F117;
	Mon, 16 Sep 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503898; cv=fail; b=DeJJpjZam3zoA80xJd4z79n6LPc+fWxw7qMLHF2nNuOijtuWuTMr4MN4Z/XVHXUBz6odSO5mDhtuRb1sLm20IhdJS9lxc/kD5Ss6ujHKFsH1pst4OJSzYbH94ILcE7462oK6MBEOBujIhJ/arH5p8fih8dbtn9Y/eSVhIC5myiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503898; c=relaxed/simple;
	bh=uljLJ5ZYxz0Nvk0JUuHzJrQVSM8h5LF++0yXgTJjx0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uCw0ALochhRbbXkMJ70j/oSFFgcN+3gTG1WoiP88x/9u3SWyfOXAsfilykFwUOfUReNKPyCAZu+jGIGyQKw/Ie2uzN715P+qp0xVtyMIm+tpk8JtDZETM58VR54kqDjjYw7nGqFoRlh8hRlsBGIzo9mWymE9prmyXPYRyqf2bTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pbx8JcnU; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+DXu7eQ1Pk+EuRxPEfg2ZMcVfTZLdWwff0/c16H1Qs9iBowuXsX03Dtw0Ltdfa8T6oi8x8pPdcq+9S7g2Nk5jfAfUGPL3s0PsCrU5xJf+Pi28Ka+rrn6rh4mkGDIlvo1i/8DcO5BXQ0q8/rkE57lxKZ/285Z7xH6zK6rRmpDOLVRbsDgtuSJvsdBHb+EkfnY1eHKdn5qaau1BL3FJqYQ1rLlwo0fXRXG6yxexuskvssx0Pf6IAAHvhwiDyG0F5Pe7CPEjbH4boe+OT+7Yna4ZJ+/eaIMNur69eFfvAeK8mAH/lWyx7huZbYKXigzSCCn5GAjZcQKGf1Q+jLSo+Lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt/Z+nLSwU5+4dxqD66Je5mhizIYxZSh2HvLUwpJDWI=;
 b=Cy9Dm9B6br+xjB3QzEz7dk29WlFtF7gGXAdnoV+onlIs/6VCcx5psiPSuID3jGq1uo++NOwgUfnosC+4FcuF7WKSX8sI7LERs7Bcvy2Pbljb1CTUv3Pw26foQwxoPdjRr8rKesmEeMaHWqG3gDxd8sDtzjsCOKQIwqo5CmLPA4OBU5jCp5vVOSUxSWSUTspGU4WBj4sq98Ci21yE2b+0EgZsHHt2YJxBfFteBnzAOlbWLWJnjVty5D1fm/QTmPxYpTHFAKmQzUBIvWXngLkjgXw+9N2m0YfLWDgaaiwXOHv6Xkj3Z52lV/Ij5kFz8IrVAzVvp1RBSq7hjIwjiUyR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt/Z+nLSwU5+4dxqD66Je5mhizIYxZSh2HvLUwpJDWI=;
 b=Pbx8JcnUSP+Cjo2sNxem3ZeLlvaKd9UkGgVDuuy5fZsM/Dx9eFZfNW2KMxehBKGyXj8bw6p7d5ub9yzbqiRL22gNAO0TTU6bKbUtXbn5UULFgXeDuSot+4xAUOdU0f62yBU1LVRlsL/ePHswiDZdWJFxYMr0CvHWLnA4/PdMhJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:24:53 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:24:51 +0000
Message-ID: <7b62997c-2b27-2cc0-ebe7-3ef17b51e596@amd.com>
Date: Mon, 16 Sep 2024 17:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
 <20240913191009.00001eec@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913191009.00001eec@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: edc2fb18-e270-4782-5780-08dcd66c155b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVF3aXpRTUEyMXNic1dWTUV2R0xma1ZHRVZZdnVnZnlVMFIvNWQ4eXp3d2c1?=
 =?utf-8?B?OEM3Q3dwQ0l5ZmkyMVpmMXVWM25aUjNNRTYyZjZESDByVkxITUE5dGp0ekhy?=
 =?utf-8?B?ZVlMOEt4WWRYVVJ3ZHhJQ3UyeTRGTGlyYUpxNXlaR05KNEJYUGdHUCtac0hS?=
 =?utf-8?B?Zm0raEhHTTJCaDFPL1VUYnZ0UkJ0aDFiRVBpbG1TTHZEcHRlT1hVRTA2akhR?=
 =?utf-8?B?a1JxUUp6aEFMZW00bWVhUEd2c3JLK0ZwVENXdFFZaTJlSXFUUUVQaCs1TVJK?=
 =?utf-8?B?NCsrRFc4eEcxUEdYdHdobW45aS9OUTZ4eGRwSS9QUVBrd3BTalpnNEVWaS9s?=
 =?utf-8?B?TUpqUGpUNnkyNzNsbXVYaWgrZ3FEREExTWFBOW9ZN1hzVEFTRjMyR1QvdGRw?=
 =?utf-8?B?RmQ3cmdPcjVVVHZGYlhldTZnYVl6aUpCVUhwQlRhRjJpMlZIZDJ5VFcyRXl2?=
 =?utf-8?B?QW5vMlV4Vk1GME0yNk9ZSGF6MG9FODl1L05ZN0V6dGxJWFR5NGxpLzdUZlNV?=
 =?utf-8?B?SUdIRG5aamF5UjZSYWZ0OTRXZm9PNlpFUi9ZbjhWNGZxL21EZnBNRWIzOUxV?=
 =?utf-8?B?TUN5MnFHb2VORmRYWUg2THorS3luMkgrK1hEZklybG1OQUt4WFZpSk5zdkky?=
 =?utf-8?B?eStEZ0FFSzBlcDdWRFRlL2FucW1UazlsQVNwclNPaGRJRWZqejFPd3lKZGRV?=
 =?utf-8?B?MkQ4TTBSWVAvUDdNQWllT2hoYml4a1B0VkEvSXNidnh4aVhudzB3S2llVmgz?=
 =?utf-8?B?Qmh1bFVMY3dlT0lQYmJnMmFldjNqWkZ1KytFMmZYQmJQQ0ZBMmZSYzhUV0xH?=
 =?utf-8?B?cmppRnFqTEgvLzhIQ2NSTWpyT1c5L1FUT2lZeWlXRWRUb3ZuUytRSCthZzk2?=
 =?utf-8?B?SFVYRnRtR0xoUFRidTI0S29HTnRpbXhpaFpzMStYNnY3TWFpeW54YTNBWklT?=
 =?utf-8?B?UndVVGVlekRjdWVUbzBnYjlURHplUWhRMDdyVlJaOVJSUnZkRHlQVzNkb29z?=
 =?utf-8?B?NG9mYyttcHc3T1JJL3hSczVJUnoveW10NzdPdUlvcGpFMkw2NnNER2E5RVRq?=
 =?utf-8?B?L3pyTVhiV0lrUVRnR1IzSEJJQVBCTXhkTmwzL0N2eXVWUEM1SkpYakRlWTVZ?=
 =?utf-8?B?RmNOTEw0UzBrd1ByQnBSMDU4elBUZ0RLa3ZIanBEeTdkckhNc0M5V1FHTFN5?=
 =?utf-8?B?dG1HWFhoOUpxYzBsWWtzK085RUN3K0JXc1VhdHVjU29oNG1QYmN0ZlpoTkVM?=
 =?utf-8?B?UGNyK0lmZ0ppVWFyUHBWNEVFeFp2b0piTTNiWURTZUhlNjE0Q1FZK2lqNjZ2?=
 =?utf-8?B?V2t6anllV2FFTkE2eHB4UytQNEF4TmI4MEhQYngyTXBCRDA4UGFYeWR2eW5w?=
 =?utf-8?B?TFVpTjRRQkU2c3E3aHhJSGQza3JpY0Q3QkpoMFMxekdwYWo0bEhnTllFaTAx?=
 =?utf-8?B?WGIwOVVrVlFISi9RdHV0clVyMDBpTzFMa0lJaWZKQkFKYm4xeDI3ZWNuTFZL?=
 =?utf-8?B?RzJYb0U0RENTQi91dmg5bEpHNXRqeGI0VDdqcVFZSU01NWNLMTA5UTRyUGlX?=
 =?utf-8?B?WERCcU16WWVCTVdScWl2VGxPcWxHbHA1U3JFOWYvZlRJTzJVL0s5RnN6WFQ1?=
 =?utf-8?B?ZE9yWm1MNHdBVVNnOUZZSkZaSFlQMi9wZ3huUWJjd29DZ0dyOGFlK0ZYQ1lZ?=
 =?utf-8?B?YlFwT20vazJZMFJwdDlzNU5uUDFobHZSVTU3cEZ4aTlzUUZCMGlLVTM4TExK?=
 =?utf-8?B?QzJGbmE2NTF2ZW9vMWVrSzRnU0NhWFZpZzNGSnI1aEtlYkU1ZzYxNUdIMkZ6?=
 =?utf-8?B?eE13QUx6a2Y0aUd1R2U1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cklqN2M3ZDUySURXa2ZWZUNIUVpVUVkyYmVDQ0tWdHdFdHZiUXAzTWg4TDZK?=
 =?utf-8?B?K2xTcG01bEo5ZGtHQmdhaHg4Q2dteU1lTWdPZHVaUHgwaHFhbEFYMWVsNFV4?=
 =?utf-8?B?SHMvczJqNzk4Z3dvbWswcnZrcDJXVHd4NHIxNjVmZllFWlc1SGNOOWxlZ25k?=
 =?utf-8?B?V01tZFlNeXZEZ2Y2Q3BURkFTc0lRdzltL203TTNYdW9uUlBiU3NDU3ZTZzVw?=
 =?utf-8?B?S1B1a1BEdVh1R3ZOc2FaWjhnOERFa2tZTEErOVVSMW9GZk5rMG5OUE1TcjBP?=
 =?utf-8?B?SnBNVXJFUUlmN2ozeWlhYmw1NDk3UmtOR0RsNkdPOFB0ek04S2IxK1NNVUpV?=
 =?utf-8?B?NEV2ci81bzlzV0JyeHh6dy9KYTNoR0lLRjBRL0JwK25HUk5MQ0cxSDVtSHlN?=
 =?utf-8?B?dmJMYVovalBQQm9GNFFZQ1NTWnFnY3FQQUhRNU0yTlFaOXNQaENuUU9MYmpy?=
 =?utf-8?B?ekVYTUZHOVhoOHV6VDMyOSttSkxzeXBnR3hBSVA1Nm5UZG9KVUlvZ0F5UXNa?=
 =?utf-8?B?SHVpL0IvTW15OGZhK3pCbjhQYVQybG9SYWZtRlNRd3MrYW9OdERyUVptczFk?=
 =?utf-8?B?c1NWa1RRM0hYYlVaYU9SUStFbG0zWllCcGRNVFRvMlB5RDBjaExVVUhqMVQw?=
 =?utf-8?B?bXMyZVBadEhKWmQrMmVBUUFWWDlJYXJFZHh6MXlxRTRhOHFsaCtpN21lYndD?=
 =?utf-8?B?OE5DQ3ZJa1NnN0ZzczIxSC9BTUc5VkNEQTFEeXluaS8zSHgyNkMxaWExYkNH?=
 =?utf-8?B?Qkl2OTVqd0VVOSswbXMybTdiMDUwV0pXQWNrYytYMmZsUzhkV1RxZHpLL3di?=
 =?utf-8?B?NytTNXdpTjNUM2FwZlNud2dIWC9OWVFGSXJ5c1lSUStUclB6Z3o1OWVJMkcv?=
 =?utf-8?B?dmJrNEdydnV5YU1LeHVtUkY0YllQeWkzM0xXRWoyUHI1SWpwa2p4ejJteVli?=
 =?utf-8?B?RDhtVEQyaVhxR2kxZDB0WGphSzFlMGtJZG1YY3JoT0xibWRYbTZIZHlmZysw?=
 =?utf-8?B?cERqMTR2dUpKY3crWUdxOEc2ZHRYQTdZMUtITVM1a29obElON2NESWtDaTQ0?=
 =?utf-8?B?czRzZWhOYThhQzBOU0NSMzV0RVFqNHNYRWtXTlFVRFNRaVROaU1mQ2NKMGtK?=
 =?utf-8?B?dVFHYkpiRFo3d25OSU5yQlo5WDVLWHZkZU5ud2NJTkV6cThFUXpVMlZ4cEly?=
 =?utf-8?B?ZEZieXFGYStwTUY3M09qRXdoOS8vR0JOYytNQUN0UmVvaGRPVFdpUnBFWGJn?=
 =?utf-8?B?V2pXTUlESVFabzhmNDBVUXpSZjdMSDYrVnByaktCcVQreFVKT1F4NG1SdWp6?=
 =?utf-8?B?d29pVzZ1U3BSV2pOSU11ZXRZZU0xbFV6OU9abzB1TEF1U2lNaEEyY3I5cUdw?=
 =?utf-8?B?eHoyaFUwZFlraEsyN005UVpSYzV1L3pDOHc5QUFHYXh2Vkk5NjVzWGVmM25Y?=
 =?utf-8?B?aW9rbm1KeXdXTDY4d3VuS3lwVWM4MnU5YWhJV0wrVTQrTENpVk1zZjV1UC9r?=
 =?utf-8?B?UW9lQURLS0hMUnFkL1dTSS9jaUFhTTRrT25GZ0F3Zll0ZTFsRjZrUVVYTTRa?=
 =?utf-8?B?ajRkSldMakRncGpnblczd2VNb2dPd291ZWIvVS91aHpMY2RpT1dnNElkUWFB?=
 =?utf-8?B?QmVYdE10SmF1S3ZPU0paRkJrM2prOWVtRzl3b1JxRE1mUFJweE41bGFYTTRY?=
 =?utf-8?B?cXpuWVpoM0JIWmovc2NISDg5RjBLVjRnMjNBSmxBbmxYem50NlNzWWJuQ2FF?=
 =?utf-8?B?a2JXeWJXQWZKM1R0ZDJUL0lGQU1hbjdFeU9ZbEtZYWlacnU2OTcvQ2libFJw?=
 =?utf-8?B?ZUJWdlZlK0lNbnBvRmxMeWRaSzNxYWpncHMweitRNWZLK1JCYTRrQXFkSWF1?=
 =?utf-8?B?ZHU1RE4vMHE2SXJ4M3RJYTQ5amY0cjh6MWN1UlpubjlEMnVkaHhXcHA3djhH?=
 =?utf-8?B?VWQ0ODEzRWg5TnBXK3dNaHh0eE5XbEF4eUNqRUo3NFhMUjJOS3dLS09iTEdn?=
 =?utf-8?B?R1hjUHFqdjgrWVVhU3Zna0RaSXRKUk9KUDBKcWVlL1R4NFg3L0RiUjdvcVV6?=
 =?utf-8?B?NlJkVHl1YTBnSCtMZUt3OUhZU3Qxc0dYRE9kSlF4QzBIQkhMYU96MVhPQ3B1?=
 =?utf-8?Q?a6h7/2c+eL+rHOyJVPhNnhPI3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc2fb18-e270-4782-5780-08dcd66c155b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:24:51.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL9WzvvhZmMVy/wmu5x75JFGxEXWhOgQWjD5O5h3kb2nVeONPd0UkjJyXprN3aWEtRDFOCuGCexIDWdEqKjOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834


On 9/13/24 19:10, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:36 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> One trivial thing.
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index dd2dbfb8ba15..ef57f833b8a7 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -21,9 +21,9 @@
>>   int efx_cxl_init(struct efx_nic *efx)
>>   {
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	resource_size_t start, end, max = 0;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> -	resource_size_t max;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -132,10 +132,27 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err_region;
>>   	}
>>   
>> +	rc = cxl_get_region_params(cxl->efx_region, &start, &end);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL getting regions params failed");
>> +		goto err_map;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(start, end - start);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region failed");
>> +		rc = -EIO;
>> +		goto err_map;
>> +	}
>> +
>> +	efx->efx_cxl_pio_initialised = true;
>> +
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   
>>   	return 0;
>>   
>> +err_map:
>> +		cxl_region_detach(cxl->cxled);
> Odd looking indent.


I'll fix it.

Thanks!


>>   err_region:
>>   	cxl_dpa_free(efx->cxl->cxled);
>>   err_release:

