Return-Path: <netdev+bounces-97650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3738CC927
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E359284500
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C514885A;
	Wed, 22 May 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3PsWmdzD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D9148840
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716417731; cv=fail; b=Svoa3qlQ+x2QbKP/BSsSYyjqVqA11xQQEFH5E7SLmFeqyjA/OGeTLFPGvi3ZDD6MDpJ3i8RO0iDsNmaURfcVk1C6lWZrSjmxIMRwc7aI0hgQGDW+J5e+77zKWhSJ22KVSlkloN0iu5uaPxY0NO1+NLkZkE0xDJbS+jd2Yy0RgxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716417731; c=relaxed/simple;
	bh=YuhbkLC5ZNRzygxwhkwpX7vibpdl7OX1XYHKqS2gvbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJck45aW5ASXkT7SCJhQoKOrpHyUmhf5ZkDmj2q9RAer4Qlgwe9yXLvZ0c5CWqocIUc5qcvcsiSNXhTDPb0hCb0H4LOkP8iGbfot91+K1aFje3fFnTqQQyRkb5+NBKO2XRoM+ihNcdSEvfaNaK3U4HPlCZjzADACB09FZrfJqqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3PsWmdzD; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFMSOfIqTnqZdROa15GkFBq0O9vNOY23gWSq7LSkVgU2IDUUGMmQ6rI38oVqY4NlUvv+c1w+WBelHggddBOpALQXaf1DzlpdFrixH2BGX2jGDeoT6npxOh6gdFT31tgauZce2+qMvShAsLAAMBZvOIuQviNsfh1LNZ4OPv5DzM/n8CamCFKMRFnsAip+eCOP6Azy3O7M1GwnMb3729ZjUmJxhU6dBY/k3sj2qj6OGmo/COiIl5IpGlFlFxxbJTcPbOq12xWWg0C21VKut5dbrRyztdQAZogCl4NF5qrAoSE02SkUQbc2LtZQmEu/hSuaDH2Buk7dItwWyVfzo0WSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDBBOHe9nk2fnQZWDgQpgqOiRFggvstnQzkmPpIySl8=;
 b=hYx+rIohDbNIWmpk/2YhH7h4+D0i1r9DkqpjoTe0phWJ6vbi5QjqR2XvliSfi+4C+YZqQfMZSxm80BkMO7yhPN36PPHeGSC+V1dvD3atoaQU+HWGUof2FNkYO90x737ckfGr0Ul9RSL5Z5qEeZhCrK+5+LqxofsTk1QC+GWenWIt2EN6qWMuEvKu9wFbkaKjwNp+nF/dQhWnmVNwnp0rmD/s16q+mJPBcz+iQlkW3+H8xjqFe+2sxUpUGx2t1pUNmhpaohExjzobQm8nLybLZ0iXVnVJuTYKUsF9DmAv+BLveg5xLMaKPlPmQ6AX101lKesSvnHrm/k/z+SjRcCwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDBBOHe9nk2fnQZWDgQpgqOiRFggvstnQzkmPpIySl8=;
 b=3PsWmdzDk5vfzgbBafh5ssAQeT0vQKAOkT+JXZ5SHr30ZwAautuuA0YXNIZeVHCAtBQfk05x4rdhHUvQ0xheV+jHXr5DFYMxu5MHb9ogr/u+6RFRwmxPMzLRBSl5pQaLhcUjR8D+/5pARErcYLSSKT5/8gPqJnoanUEyWWQUHPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 22:42:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 22:42:06 +0000
Message-ID: <ebb4a654-05c3-4d17-8ae8-46a4dd9d4db1@amd.com>
Date: Wed, 22 May 2024 15:42:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] ionic: small fixes for 6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 brett.creeley@amd.com, drivers@pensando.io
References: <20240521013715.12098-1-shannon.nelson@amd.com>
 <20240521140631.GF764145@kernel.org>
 <e68cf441-e877-4cf8-98c6-86b6067364a8@amd.com>
 <20240522100404.230e4bab@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240522100404.230e4bab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: c812d116-212b-442f-6105-08dc7ab0682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTFYM3FTcUZ5YmFzaDh6Nlk4NXRBTEJtbDRKYzhCRUVlMldJVHBPZUIvVUhi?=
 =?utf-8?B?T24ydXBNK2tDVC9JSUhFUnhNN3lYbEFUSDRXbVRiODhRRm41c1ExRExIaGty?=
 =?utf-8?B?dTRia1M1VFk3OXFaSVZBeXRBRFNyaTZXeCthckhKcVVDRXFFZ3pKamd0RktM?=
 =?utf-8?B?aHREbFp6d1d5OUhCWFlXaXkyTGlaY3ZMbjk4UzdOR29hUHlvR29RTnV3dUhi?=
 =?utf-8?B?Vld4dmVjcHowZlBGUC9ma0FJbm1ubFEzU2UzV2VNSzd5SnhqWC9Ia2ZLaFcy?=
 =?utf-8?B?NmY4bUJPZDYycGoySExvNGV0V0V5T05POXdJSTNRZGdBOEViN2FkdVNwSTFZ?=
 =?utf-8?B?MENpVmFTUEJyOU13OVlIdktaZ0h0MEJFQ0NodXdJY0ZBSVRPS0dCZFVXcDYx?=
 =?utf-8?B?d3F3UlNjR2Z6OFZBRTJ6b2NvNWN2bzdZTlN0dkNVRUc0dnkzSDVtUlhZZVkz?=
 =?utf-8?B?SVJ5VFJTVmpseEJ1NFJ4bkVtR3ljbHo4TkxnWThmSXJFNW5EbTFlWitwWGcx?=
 =?utf-8?B?TjhCT3B2bVNQMzRqRGtZczY0UVFOTHN5UVI4ZXdhaGtnR1FyeTYwUytTZCti?=
 =?utf-8?B?RnI3ajc1ZVBtTU85eE14MEovRThxRDg1TndJaFhoQ1NWVm1ucithdngrWCtV?=
 =?utf-8?B?YTAvSmx1bTRYNVh4bURZdDlhQ2psdGllRUk1WW9YS3JSdURUQ1dtaEcrb3py?=
 =?utf-8?B?enlGV24wbzFFOVBNVUFDd1E5ODNpbVlZS2xCbDIraEMyUUdLOUp5UVVteVcr?=
 =?utf-8?B?elNDK25KZUtzM0V4aThhc3dCTnFzeVZ6R051YnZ1VmRXaE1LYjFEMnQ3QVd4?=
 =?utf-8?B?VjFyL1JLaTgxSkMxZmFzc25wVDQ3VjRCZjVNZzBiaGh1VDlUZ2p4MVNrOWty?=
 =?utf-8?B?UEN2SENWUjNxTTdqbWdzMVAzOVljUXNlN0czVGpvbUJMS0Q2UkFHSVRuWlhB?=
 =?utf-8?B?Vi90MDR1TU56REFXN1VmRHduRGVUZ1RwWkwvZ0NGVGtOaXpDblc5UUNUZWNI?=
 =?utf-8?B?SURkcjFuTEFRUVU4aENoNW5LTEx0cGpLNEdOVDhaTjBTSGlTTUNLNkRQU3JG?=
 =?utf-8?B?N1FoL2owZjdPS0o0ei9tTGJ1NHBpTEhCdkdYQVlLV2FDK25hdWpQUkNwb1hs?=
 =?utf-8?B?dlhDcXoyaXVIaGhkVExlcUZPRU52K3BYb2ZBODhuVzFMS0l1V0VwUEFYYktr?=
 =?utf-8?B?YkJxZ1BFVEtrT0tqeTIvcnNQckdueHpSYWFkUng4T3FROExCQ2tzU0E2YWdJ?=
 =?utf-8?B?ZUZPMjVvZWw1NGkyZnIydW9zYWUzNU9xYURsRm01ZjlhSUlKeWNCV3NLckZO?=
 =?utf-8?B?VlJXS2tBN1VmU080MjkxcCtDSnh6YVRYNVZxSzlHMk5UNWZsSkt1U1BwNnFn?=
 =?utf-8?B?Y2c1cnNFUDRIM016R0RCOW9pRmc2emQrWU1sdFU1ZDc2UUNvWjZmTnRmekEr?=
 =?utf-8?B?cWpMMWhIMHZ1WUhvdGxnNEhycjVEYTRTVWJXNmxtZnRMQkRvZEtZc09zZmt0?=
 =?utf-8?B?QU1CNVdwdC9JcE5NUXRKTVRTdzZ2a0JHVUE1SnFNK0lBbUdtWUZ3cGlSaGxF?=
 =?utf-8?B?d1RUKzg3Z24yRGJuVm1YcStkY09XNktUcG1lcyt4bVpVTzFPSXJnYmZoZFZ0?=
 =?utf-8?B?cXg4K2FtWFRRekd3QWFZc3BHODdPU3FsNFp5NjNIZ1JleUl0QWZMd2VnRkE1?=
 =?utf-8?B?SnV1QWd6cTY0a1lvVFkrTFFaRjgwTUxyZTgyNnR0WDZhOTQwSWlKUUlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lZUHpyREhTL3k1SHBsc0Mvc2ZVRDFtK0dXc3YyTXphYmdHaE9ON0dLa2Yy?=
 =?utf-8?B?S0t2ODdMRUNvczc0cmdwckZjVDF2VVIra2JyRVRVeXNIdWlxOVViTnFMZmlX?=
 =?utf-8?B?cDFEcHd0WDc2QkpxeVhaWGQ3dEpNMGw1ODg2OFlWVmdSenphMzdTNmFwcVBO?=
 =?utf-8?B?dWNtUmF4MFdtN0R1SFJTd0NvazJqM2dXRHc1S2RxaDhGVFBkdHlLbTdkYnNR?=
 =?utf-8?B?YWIrMU9VZnluU2d2K2g1UHA5b3ZrSXd6dmhSODJaZXpOcDlORXNaQ1E3UERy?=
 =?utf-8?B?eTVyemhPZXczYTVURkdPUEEzUkQ0NktlZ2ZUVmRNUjFYTWwzTjBRUjh5dlp2?=
 =?utf-8?B?cFp5SEw2bS9oVnR1anpjS0NvSUVsSUtQZEdFa2hrS0pUZG9jWitzN0FJWWhw?=
 =?utf-8?B?VkphQXBmeitqMC9HaUdxUjQrdVIrV3FYaHhRaXlVK2Vwc0xxVFFYc1FTdnEz?=
 =?utf-8?B?ZjZEbmllQzhNbFBKS3dyVjlzTFdKNm51MTNRZzVpdEI5SkpBaDVXK1FiNGNU?=
 =?utf-8?B?MmxTeUZKY2RSWVlPbkhNL2IwZ0JURzNDVHFVOEo5NzNlU3FINGlkZmg5YWNu?=
 =?utf-8?B?L1VjTSs1R1IvMkhhdTlQMkFPVERYUmRxZXlLOGVURHZuL2xucEpqTkxESUtj?=
 =?utf-8?B?dDUxU3dKLzRLeGlheG1jaEdVMEZpcDd3V09iVk5kdThIcXIweWJaUTlSZzhP?=
 =?utf-8?B?TUhBbG1GWXlTa3YyM0U3Y2g4VG1EV2NxZmIveWpyR0xHU0xXaHZEbElmMVJy?=
 =?utf-8?B?UTg1NjdnL24rODhQTVRrbEdKMUdlWEpyYmZFNXZHQ0VEdHFIOXZYR3JhRWp5?=
 =?utf-8?B?K0RTZjZXU2xyelVMQW9LbWx1K0NDS1BJTDhUQlBia0lDS2V6WlBqS3Z0TWti?=
 =?utf-8?B?cGUwUUpzL01LaTVuNGk3ZlRQRlhRVVJCa2orTmJ5cGJ1YXdLY1lBQTNtUFox?=
 =?utf-8?B?aVo4ODVXa1FyQ3VJQlVkNFlFYlFFQ01VS2pRYk95Q0NkWE5BOWhON3pIQ29W?=
 =?utf-8?B?NkprNGNNN2NJTEhHcnR5emFuSVZiemovTW9Gd2VHNzRKTFRlVFcxWm1adksv?=
 =?utf-8?B?QnBMRG5MV3d2VG9rT1pJc0lVaCsvTWwwcEQ2WGp2VGhXWXhKSUN4N0poUVZC?=
 =?utf-8?B?dVJQZDhrWXNuazNIYS9EWlJ2VFhoSDdiT2lnSnpYRXUzSUpTTUJNOTNaMnkw?=
 =?utf-8?B?dkFWR1pBRWJ1RFZldmt2UDMyUTljN3Noak96MnBVSU1qRFh0Tk8zVDIzdWdE?=
 =?utf-8?B?UzRDSHBqbnlMTm9tNnlveDd0ek9OMkVIMkdYQ0VLSWh3TU9ZWTJJSnpCWHpI?=
 =?utf-8?B?ZEsvQTBnaW9lTkdUQzZuWmtOR0RaQk5iTFJyaUJGTlF1L2JubndzWGZlSDlO?=
 =?utf-8?B?ME9Oa2ltSi96NTRWdFVWYmN2QmVPckdwdU0vYXBHQ0FEQXdaMTVRSDZxRVRE?=
 =?utf-8?B?ZHRkbDZyRStvWGVzT0F6Z20rdVFYK1pobmw1R01XSDQxUkdVV0VYb1lIcUNX?=
 =?utf-8?B?dHltc1IwcmgwNHZwdUxnRm9YT1FHNk9yUDhkVE13dnlaNkx4S1c3V2NqOHZp?=
 =?utf-8?B?K2U0UXl5YUtQaHB4RDdWekxpV0ZFUnI3d2Nucm1PZE55TEhLc3VhRE9kWHk4?=
 =?utf-8?B?U3N0ZGhYVWJtVG96cndMeGRRelJFVGVoWE8yWHQvT0xoMlloWi8xK2c3YmFD?=
 =?utf-8?B?V3VDTnk0dkJEZnNSUklLMloweXFWUHZMNzdubjFKd0xMNk03SUloOXhCcWJu?=
 =?utf-8?B?aTkrOWdJNkNXQlQ5MlRxMzdMSkxDM0pNQXZIY2R6am01dGFVVkQ5SmZCVUlO?=
 =?utf-8?B?cERabVQ1ZTNRWlRLOGVOOXE4M2c4Vnp3OERYTXdQdTRWKzNuY1lZaklFWG16?=
 =?utf-8?B?TStEZloyL0pwcUtwUHBCSnVYR1dhdW1mUGxQcmcyRlpBSUhrZEd1c29teTBR?=
 =?utf-8?B?NzZwWlhGTXB4WlBPQ2hnM2tHQWpZT0xxVWQ4UDllN1VDQ1p1R3NDM01BcHpY?=
 =?utf-8?B?a01pUGMrVVRVMU9rRVU5cGZnZ2ZueUFiYVV5dDd1YmpCVExxdktUaTgwQmdH?=
 =?utf-8?B?alBld3d3dDgyVGhmL1M1WmI5L2VscTFlOStybFJ6Vm9CVGY0MmlUSnFFQ2tm?=
 =?utf-8?Q?5Vf8q+e0SVGmswU3jiMjzqxvo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c812d116-212b-442f-6105-08dc7ab0682a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 22:42:06.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC+LfVifGe9T710exOqBqqGG0wL6PPrZqpFAGhRHSYjE/jrZiyDIra1Q3nigSQ2gXJBMjQufk+LGmReth6r8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 5/22/2024 10:04 AM, Jakub Kicinski wrote:
> On Tue, 21 May 2024 10:14:24 -0700 Nelson, Shannon wrote:
>> As always, thanks for taking a look at the set.
>>
>> All of these patches are fixing existing code, whether by cleaning up
>> compiler warnings (1, 7), tweaking for slightly better code (3, 4),
>> getting rid of open coding instances (5), and fixing bad behavior (2,6).
>>    It seems to me these fit under the "fixes to existing code" mentioned
>> in our Documentation/process/maintainer-netdev.rst guidelines.
> 
> I think that's a stretch, Simon is right. Maybe we can take patches
> 1 and 7 without the Fixes tag, just to make your life easier.
> But if the rest are fixes I wouldn't know what isn't..

I'll respin them next week for net-next.
sln

