Return-Path: <netdev+bounces-136956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDD9A3C11
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87AD1F24FA6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E42022EA;
	Fri, 18 Oct 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZg3MWvx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFE2022F9;
	Fri, 18 Oct 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248629; cv=fail; b=DxRgMevqHQ3btOKyl+DiCTQcQ8uWT9/gRAD+hZ1MvHtw+4kX4qwTHjR3PnI6U/aiRsEnSeAzXymrBAX2svP38xIvHOKDcSQEdm/ekhFR6wfgXLoG/2dMNPDssfkPWzmDJZjLQZciTJbem+ev+HTP38DAuYnVnyNlTBPCJ92ep4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248629; c=relaxed/simple;
	bh=UUMBE2IVU0Pa//DXQEjLIGtLhTNqcees3L7NF0h48Lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNTogUVY43kT8w5Nky3uMfDU254KyfNJSxK+zc8qhlhKegWnPf+20U9y+del8n1IjHdlt5O9SK3YSonDh83aLqjkdzk0kk7fXKvvc9MZpDOJDSy0E1G68WcxsCd77GuJ5XvZe+MXKJW5JAOmnLe307lpjZvYTV2gG3dGecDmR6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZg3MWvx; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWeAGkg4bOO5T1b/ubb88SY9tk3RL6nr0IBl3nQSCiMhCZdstLJJYns+XWHIVZHELyccQy9s//BpVncnWYbL3by6Rz1TWU7bbNzU4uBKcNKfFIrMWk9n5KxVjJDUqQth+ECCiprEGT+M6FbGV2H8xiNffsvSUvWuJ9kNM4hghvUy4yQnn3PmDpfcM83+HByFVsokX7kddx8b6Fh/9jDF5BAmUpAQ7tB+jIZQ9IOmyS2PaFb9XmVtP6qRm+X6bWnQ3uBvqDGGwPjKDakckmuKI6YpdlOgIyGo5TMcOD0FKd4ozz0aaeimJ2Ic2cLzTmx6p8cCqyhb5woKraLM9TOllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l1C0M1tXAKq0WManwrNQ5hl4SouwUbFy2kbx0GECyE=;
 b=SHrHpcO8IhePcNzZXtkZ8dPfoQQQlI5odJvBFqzn66HaZ7fdHFPqnvfuSfsx8YQYwjbCAoW6dwu2RcgT3LXFNrGqD/1ILbxKL4UlkaC43n70uohlpftKq5C2YWlNWSPF9lpmRSEY5YLsqov7xEFkEDOukAmBM0sGuVmceI1DIqu1gFDNG2O5gPT2BD+9jbc99ev5+79bsMRLnA+NjWNGOF9AGrMK3bdNdC4s29TaTuyVowaXjJERm/ecUD9ux7s2ylxQEy6s5sVcoturk1i+bkqIC6zJTbTXH+tJByiiMtvFZT0DMmqd3avTn5o3FjuP0YqFrxDBGnQQ5vHTFRaueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l1C0M1tXAKq0WManwrNQ5hl4SouwUbFy2kbx0GECyE=;
 b=zZg3MWvx6JHC0ry47L0cdzSUwQB8cRrHxJUec9sIOMDTQoB7Z5IogBhGyiuuN9RzwhtM62xzSegAikQkcAyu8kr5p+SF53GwzQJnq2qzBNVXLwAZS4TCNUs5xcNLze5vBhwbfibDRlUP+jt1EA2nKpK/IAnahYnkErR9d2Mc3wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 10:50:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 10:50:21 +0000
Message-ID: <e3a4aed5-e3b1-ee00-1b94-6e45ee979fa7@amd.com>
Date: Fri, 18 Oct 2024 11:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 13/26] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-14-alejandro.lucero-palau@amd.com>
 <ae4e2c7c-f0f5-4e83-a1a6-83de2c254015@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ae4e2c7c-f0f5-4e83-a1a6-83de2c254015@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: baa7a021-46ce-4dd9-7370-08dcef62a9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVVXWWNYUURCdDV6ak13MTVTTzVNdGlrcml4RDZNRDNOUXgvaGllYTRzeVRh?=
 =?utf-8?B?dUM2ZFlTdXZhZHY5czQyOXZTdjFqUmx1bUI1TktqREhiTjN3dm1PV0R5dlhw?=
 =?utf-8?B?RDJpYWlPVU1OVnc5WFh4OENzY0cwU3F4czNLNHVtajJNbVBZZzJONUUrTUNQ?=
 =?utf-8?B?aTViSUx0bGFJbERTZGxaYkd4YmV4TEZPNWcvK0JoVHM2OWJJSHpHOFRiTVZU?=
 =?utf-8?B?WU96LzhoUVVuK1pBMjExenhXZU0zaG9OeFR5aVBZdktiRm5jb2lOT0RhZTVK?=
 =?utf-8?B?NnlINjNWSjJ6TUM0U25YaC9SZFpoQmV0LzBEaUUxditrY28rVjJnRXczdXJB?=
 =?utf-8?B?SFJ0QXV5ZHl2OXhybDRGT3ZBVGtEUVdnbXRxaXlHTjJSNkhCRHFadEh0NzZ6?=
 =?utf-8?B?ajYvSXMyYlRWSEpaMjBRdlV0V2U1WUg0TlRQZHp3MGVLZEJ3NUFIL1FNNFRI?=
 =?utf-8?B?T01ZNTZjNUNnUERFUDVpTGk2eHVyQ2tyRmNkZEQzaTUyaTJkZnVhbmNiVWhX?=
 =?utf-8?B?dU1TQXJVcW5OSUdTL3hRa2k4aktMSWJCNGs3SkcvTmxDOE5zZVE2Sk1WR3Yz?=
 =?utf-8?B?eTVDbGFOeUc1dkdEVVR4d1BoL2Y3YVBlTnU1LzZHVnNmSUJVc29pRFVBOTFv?=
 =?utf-8?B?YVhZZGo1eDdUUkM3M251cFNsMEMwSjJzN1hobFlad3BhdDlZOHJoWlR0UzAz?=
 =?utf-8?B?USs3SlA5THQ2K01pNmlGUHVSNmpIL3ZhRDdjS1BsaHg4ekJZSnVLVDBlci9v?=
 =?utf-8?B?ZnB6T3BzSkZBaDh3eE81dnZCZndMNEh1bWc2Y21OdDEwNEJ5amY4UkNja0lx?=
 =?utf-8?B?NVp0Qzc0Z09vNDFvWTNmdUpaMzROcENiZkQ5YXVseHM1NHhybWhYUXdqNlVP?=
 =?utf-8?B?Nm5hVEovOTBRMDNqeExQMXJoczNlM3NVK1Jxd2JHTms1anA0ak1VZG8wQ01T?=
 =?utf-8?B?TldTVXpNTUxRYjBIWFJWNndjbE14YVZTTXlMZDc3QUIxMS8rQVI4ZGp2Ui8z?=
 =?utf-8?B?V3cwME5PVExBZXpiSS9FeWFjcFkyVG1ibTY0Y0hLM1VBeDFhZFlWOExzSzBC?=
 =?utf-8?B?bkNMYUlUcHFjLzF0VFoxUUhCSlRFNUpDZlhkSkVQVzBZK01LYnNjRW5lQ0dn?=
 =?utf-8?B?YmNwMzZwQUZkZ1ZsMmVhbTZmbHFDQzR6ajdhZTBkUk1sQXZ0eThoTHpTODZU?=
 =?utf-8?B?blhwbTRWQjFRUFdCc09JVmg5NFVQTWlqSmVza2JyZ1JmRW5ZOEQ0U2FOKzRJ?=
 =?utf-8?B?Q1JjZWJTL3BWUWRxYm9OZ1hYVUhWWDQ5SW9IM05Ia24rY3RlQmtWV2NrVU9z?=
 =?utf-8?B?Znczd1FtUkhCYVZ5NmRrcGpkVzROUnYrTUNleDY2enIvbHU4c25ESGFPdzRT?=
 =?utf-8?B?SUt1eGtSOUc2cFhHSHhaN2QwcWhNU0JpcGlyN0FHUEl1clFEWG9SUUJjRGc4?=
 =?utf-8?B?bm9peDl2amN3TUY4NE1MT1o5Q2NmTzZQK1k4SnJETWZsTlQ5NGhzUUpsajkw?=
 =?utf-8?B?N0dYTmpLSUt6a1pvT0o5TXNKamVHN3B2aWlYRzlTUFFFYkxZN3d6WVBsUmRG?=
 =?utf-8?B?VUZHSnBzZGJhWVplbzdwcG05cGRkYnhmWnFpdXpNYTVTcCtIeFFRYWR6TDlm?=
 =?utf-8?B?Y0x2cFB0SnBJNktJd3IwSlJBb08zZ1lvU3ljU2hHbVBmSG4rVCs0NC9JeUNI?=
 =?utf-8?B?WHFNanlzQlVYT2ZLR0Fxa25LYTRZRzRtcC9LVCt1cm1FMFpBeVl5MGVCSnJY?=
 =?utf-8?Q?G3k0j/lvq61UZChj4oNHkfLFbBIt8ryuUjJ2B0c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkduR3pXZXlydnViSHZKYm5YWkZ1V1BQMlFFV0F3c3FGRWZGVnAyZnBxS08w?=
 =?utf-8?B?K0dNaXhBQnMxeWR2cUtBMWVHR0xYaVYzQUYxNlh3OU1PMm1sMW1GcGdpRzBV?=
 =?utf-8?B?TXR3MzNaR05jeW5FUm9tMW5NODZHZ2pSL3U5QnA3cGVCU0NCbWpRQ2VSRUZK?=
 =?utf-8?B?bUw1d3QwNkFmdEdmb2dibHVvNUY0dEJHVFRWdUUyWjJKNnI1SWJYeFVPaEFK?=
 =?utf-8?B?b0g2ZFVvUFVQMXRwVEJPanN6dnovMmtYRHRoa3liZDJ3MXo5THhSRjQwc3Q5?=
 =?utf-8?B?RGZubHpMaHdsc2FXZEIvcW04NFR2eGF0Tm1oNmRuTERpa1lrUi8xRHJNV1p6?=
 =?utf-8?B?eTA3aUM5QW5uV2dQLzdjQVFjcjB0R0Uwd2xYWTBlQXNKRktwVXNlNG5uY3dO?=
 =?utf-8?B?YkM2UVBhVTQ3eG1Rb1FHSGNxdFpoenZoYXZ2bGdkME41Qm1keWROenczVzdt?=
 =?utf-8?B?d0c3U2IyT2lwdWdNZEExVDFsSjZIUG4vZXZCalZqdng0VjF0UjlwRFNJbTNW?=
 =?utf-8?B?V1ZXcFZWVWlMckVnejhpWlpPeHpLdkFJWEcvbG5udlhqTjVzeUJXbW9PVXVK?=
 =?utf-8?B?blVhM3JLQjBjZlJsa1lNTUttVDY2L05sQUxvdmpSSFNoL3pVRi9NUUVxUVFZ?=
 =?utf-8?B?bWxpVmZIZ0kxRDdGRC83TEsxWVFZTlUwQUFKZHFwNjRpOEtVOGUvTjFZWW5q?=
 =?utf-8?B?UGxnd0FoaktiRnptY211QTNpbkE1b1FlWDNEUjVISXFHSmxDcVJPaXlzNVpq?=
 =?utf-8?B?YkYwYS82VDFvM05nQndydUgyWTFCTVpQR09pbjR5NzJFZkx3c1F3MjNJN1dm?=
 =?utf-8?B?TlpCQVdDczhGRkppTWQ4T1ZHdCtISzJ5L2grTTE2Y283WjRoY2dFYUN0VUpD?=
 =?utf-8?B?Y2tETGtPb2drWTBMOEVHUkIrR3dabmJQd2dWK1hhRm5ESnB2MThTSXhCckpZ?=
 =?utf-8?B?VGx4M210ZG1teHdya3drNDk3M25YNElXZ2hzbVJXTnZHMFh6S2ZiczZ4dWd5?=
 =?utf-8?B?Q2FscVZ5RWtZTWJFL0lLYWdJazBXWHRMU0FxVTBrRVFJczVNcFptOHRRK09T?=
 =?utf-8?B?YzdwNDh5VjhOYzR4WDdpRVdkeCtidGxpZXFVU2hteUJlU2FuYURYTXViVHRY?=
 =?utf-8?B?NG5CVWNjZHRVUXRmeVRka0FqdkloT09MQ3hnRVJCcVhKTWYwazM1bDB2Q2Ry?=
 =?utf-8?B?MDBrdGQvVEJsWHZCbTkwRFNtUkVNZUZXTTRnODZXVGtUaVhobGZTRmlRdzV2?=
 =?utf-8?B?RS9nMkhrci8wRzV2enBtM1R0cmIySWVjWE51eTlUWnpGK3lwM3hjTTI3UkZy?=
 =?utf-8?B?eVpsc2tzeGg2dzh2MUZ1cmxmclhOTWxpcEFoNUsvcFRxcStCeVAxNUZ0cDhr?=
 =?utf-8?B?bEc3eHRYemlVWmJLVHFLcGowTDRNZ2J5VGVodzdIQ0J4cGhuSlFjNzY0Qi92?=
 =?utf-8?B?cWxURGhJVmhxUXN1MktLa01wN1phU0g3Tncxa1JtK1o2QmVza1hFajk3NXg1?=
 =?utf-8?B?dVptVWZBQnZJVjNoaG5lajJTYkUxSkNHdXhMMnkxRGRUZ2VzNGN2N25yU1Jq?=
 =?utf-8?B?aVpvT1BidXRFcUJXTnFKd2hXVm8zbzRuc29tS0FDU2VZYzc4MWVaaFBJdjU3?=
 =?utf-8?B?MXVyRG9VTFNZOUFaSEFkNmlBUko5L2tkemVtMExzY2k3aG1zSzI0ekdjcWlj?=
 =?utf-8?B?SEVRTnJ3ZGdKTTdCY3BEeThoUE11RFVLVVd2Vk5NeWFpdXMydHk3ZUxXOVla?=
 =?utf-8?B?NzAvSyt1TTNuY0RIV0hLdVR2aVB2MzYxY3RkQytqRGJ1VUlROVRucmJzOWc2?=
 =?utf-8?B?UEJyTElETnRpbFNVa1ZGdllGYVkvSGwrN3F4bWxHWEVyc25oMkIrTlN3Y2tQ?=
 =?utf-8?B?bnRYRFhpTno5dlFFdjBPT21idzJlUW5leDNPeVozcVVSWkZ5WEM1QUtHMmwx?=
 =?utf-8?B?VE40TWt5WWxuUTFNSUQ3UGJWWG0xSFpGOHNoWEYzbmpWNFFFTXJPRU1aTHYz?=
 =?utf-8?B?eE5JYmYwY1cwbnlEM01vVi9rWDU1RVhtWldndWUzVVhXRUp0WGcwNkJHdVN4?=
 =?utf-8?B?amtDSkkxZ1Fod3BYd0p4NXJXOGVpakUyVExMRExUWWtrTXlhdlRSbVN0Ly9G?=
 =?utf-8?Q?yN7ARR1+lKnPwdKBgHEL2FGec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa7a021-46ce-4dd9-7370-08dcef62a9eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 10:50:21.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVmc0T9tBwODaTjXgFpG+09yC0Drimgsik6I4hVhszNI5HYms4qBtVnbM8Fqlx1fmZat+5iKd00NAups0zTHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666


On 10/17/24 22:49, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
> I agree with the sentiment that type 2 devices shouldn't have the same sysfs files,
> but I think they should have *some* sysfs files. I would like to be able to see
> these devices show up in something like "cxl list", which this patch would prevent.
> I really think that it would be fine to only have the bare minimum though, such as
> ram resource size/location, NUMA node, serial, etc.


But this patch does not avoid all sysfs files at all, just those 
depending on specific type3 fields.

I can see the endpoint directory related to the accelerator cxl device, 
and information about the region, size, start, type, ...

Not sure if the ndctl cxl command should be modified for this kind of 
change, but I can see "cxl list -E" working.


>> Avoid debugfs files relying on existence of clx_memdev_state.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>   drivers/cxl/core/region.c |  3 ++-
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/linux/cxl/cxl.h   |  2 ++
>>   4 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 56fddb0d6a85..f168cd42f8a5 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -546,9 +546,17 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_memdev",
>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
>> +
>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>   
>> @@ -659,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..7e7761ff9fc4 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1941,7 +1941,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EINVAL;
>>   	}
>>   
>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>> +		cxl_region_perf_data_calculate(cxlr, cxled);
>>   
>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>   		int i;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 7de232eaeb17..3a250ddeef35 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -131,12 +131,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -222,6 +228,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
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
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index b8ee42b38f68..bbbcf6574246 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif

