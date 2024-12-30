Return-Path: <netdev+bounces-154507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E812D9FE400
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28C9188097E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9A199254;
	Mon, 30 Dec 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XLDjXk3G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71482C80;
	Mon, 30 Dec 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549277; cv=fail; b=kelb1f0c0Ntlb43NYjH1OD0ll5ekfhKrTSHdFCdBTpLEn8gZfziGkg5ThI+I5vdfG9jrbkgtF5dvmRSUhvJwzI2D5BSEUUY+v9iu3SijyN++a3i1LLKjcsH3Y65TFgVpJCab76WO6MI+k7Av5XxXpVlzVKCr0uZ9FrS4+NSxUVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549277; c=relaxed/simple;
	bh=Um50fJC9dX7i5PSNeiFPg0fbR40jQ4S2a9Qj3Myqk/s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XK8MCMB2X4uF5T/wUHJE6ffvyu0v2J0bWFyqOkLn2WzD2bxHxeejMprhc61KfRi4rXbcibWa1d6DsfSOTigp/he5TJUhTCzRSrFJCuODYXo5oQmvJXpz/tGx492IOh96lhpp6hkg7R6rFUkLopp4JRHIq0N3FPHO7+Zsl6pFYo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XLDjXk3G; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g18UyAGraD4NlypTcoh91eUTIgABoKrl6qJ07xaHvuEGj+Cc2OXkdAYnrrvOOBr+z0zpYRfxo08PZ8/TJnnAoxLd8QliKSXKCxf/6C7eK9RpYYyyfsOypiZuOLxEYN//Nk+U6YAkP/WV8vK/VWvbvCCZ7lquvZ4Z4fjn9RQZ+31BQc6OQwQd+j4/7eBlmPzJQUFNo9jqxwGQvcbCzLdRV01I8NGENiT8NVzw6fieddavD9MiLs8pVnZKZ25nt+kWij+iTjeEAukGB26HO/ci7fsO0yLW30Nm8U31WHvP+PbrUmI6L8KHJ1+fMCgJz9l06CxOGWp25195xf9bFQPYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPTaarM1o47mwhO2+dU8zQ1XRkHngB+YJKO1wiCYveM=;
 b=Gu7+P61RzOLwYmsLIq86rOJvZ0BaXWETW+Z+fSUoFV5Q8pEJplXNEefgzivVjvzIuKYMY+hvu5Ag6eoIhejYi2zGMhYvHpLlp/T0tjAzlTGMiIMwJQShFKK2QqnarQHTcoqRRvJhzFOhGg7LMTtIkX0MBbIc7xp9ser+teOoBFGlBvqmJEYJxYF+6zpkfAHX73nlNJBg1O4jkFdlLqtqDcFiY0KMH+2iZ7KIhEIjLM59XaIRi6y6mLxtw34hCl7U/yW9KrdvdsVekpdbwHAVI8yLVZNjVmA9mf2mYZ9WvnL0LNaTnXDGOwEwPOr7MGUCh3qF2kAVD5TiywcqUWUlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPTaarM1o47mwhO2+dU8zQ1XRkHngB+YJKO1wiCYveM=;
 b=XLDjXk3GkUoS+llyZvzxYWRt+O5F3lWtndwi3Fio/yKTMHKikuI/nB9n1m74Bko41xoxHESQbJGlR+JlZVCmU95XC+HkwMnPHdShRW3IeJR1/yqHHlq9oFSWRLqLFnSy6UVmbZDmM5ftsa6lW5tlRPruPMOgMsN+PpXDXbyMfuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 09:01:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.020; Mon, 30 Dec 2024
 09:01:09 +0000
Message-ID: <5e25e3a5-cf28-a3b3-0309-d21593eca75b@amd.com>
Date: Mon, 30 Dec 2024 09:01:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-7-alejandro.lucero-palau@amd.com>
 <20241224172236.00007c6c@huawei.com>
 <e814e5f4-a48f-cb12-1d00-3367f5355d93@amd.com>
In-Reply-To: <e814e5f4-a48f-cb12-1d00-3367f5355d93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0046.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: dd316aa1-de7d-46d8-65bc-08dd28b08074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2tDZ0FQOXRFUkhRR3RzdnJWdktFVS9odWxpazNTc1dGN3MwMjZVR3ltSlRv?=
 =?utf-8?B?d0ptK0hMRnIyNmVDdXQ1RW5mSHpYa3B3cUdXdFh5cHl2YTRuNG5nOG9xUmx5?=
 =?utf-8?B?SW8vMURkd1ZRT0NqVUxQT3NpSGpXY1czNHQ3VmRxZUV3YjNxSmwwNkE5bkFI?=
 =?utf-8?B?S2hkTk5QOGVYbVFmMW56bnI0OFRSazAwVjNqeXNaeEpVSXNBZEowNnJ5RGpG?=
 =?utf-8?B?Tm9FWXRZRjZWK0NUeFUxbU5vRFVXRkJvSVNTOWNJb2xVeUwrUXVQTEw3UFVy?=
 =?utf-8?B?aDU4OU54eVh3UVdVbVg4c3hPT25mcWpUd08zSVV5RG0vUEIzVnVNVWpyOTg2?=
 =?utf-8?B?YUk3TlVDNGFJa002QzVNcmlCakxXWkJMK2EyMWFKTTczZEpnang3V1JmSGlR?=
 =?utf-8?B?RWtHOEYyY1EwNmJqY2QyZDBMSUN5OG9RM2kybFV0MXFqSnBRYi9xQmpYOUNI?=
 =?utf-8?B?TXVWWHhQWVo0b2dzaWxsZEVwdzdEdWsrcGdqeW9XTVZ0MENDaE50ZlBUbnho?=
 =?utf-8?B?WHl5QjRXMzI3V1hoOTUvVFlxak9kU2VJaVNrWkZuM3F6L0daOGNIcHFUNzI4?=
 =?utf-8?B?eThkUDFFRmgweXRieE9xbGJha0hFV0kyOWlJVjZGZUV5NXNVM3lBL2JzeElZ?=
 =?utf-8?B?VDgyZUVPd0JEKzhaWEF4SWNMaTVJaFdOOWdnVXFFV2xGdzU3L2hVM0ZNaWNx?=
 =?utf-8?B?N09oc2NNQlB5c3dOQ2w2QnR1R3Q5MEgwbFNQU2JrcVYvZnk4WTNRUU40bXph?=
 =?utf-8?B?ODNSNkVMVERUbUM3am5zUzRKSGttY3JNL0MwdWJaVFZRRVZhd3lnREdiSGlY?=
 =?utf-8?B?eitrclh2TlloR0xtVE5yMUtQQWp4dXd0SWpxbXgvcVFXdE96VDdJUFNjQkp1?=
 =?utf-8?B?Si8wUFN4RExnMWc1WlQ4OVVqclRLamtKT0dyMzhJTDNUUDZtOVJkVEtvZ3V0?=
 =?utf-8?B?dGM3cXdjN0FjU1p3dGJid1l3a3N6ZjM3ajA5bTNOcVQyeW1uaEJRRlAvVFQ3?=
 =?utf-8?B?dStoZ05vR3NITGttanZDOGxhZjFva0Q0U0ZWclNuOUxQVkxodWRVUDFFNnZj?=
 =?utf-8?B?NDFTWDMvUmxoWHR0WjNDdWRHaE9KZTM0SStTT1VwUGNqNTNBTUthd0Z5TGZi?=
 =?utf-8?B?U0o4RW9iRlpGNUdhTFpxYnI3ZllMUDRwYzZEUDdxc25xUnUvcjVEamNrMk1J?=
 =?utf-8?B?ZHNhbW9nZE5vbXdPcnZaYlpNNGxxTFR0RjNFZTcvUXRqRG82NzVrVGowT0lU?=
 =?utf-8?B?OUJsa2dPVXh0R1k1UXBnMVlESW1hRThzZUl0TkV6em5GeUtuYmprWk1YdHRl?=
 =?utf-8?B?T1IxOEJmeUJ1QjlubFFsQlNRM0VxZkJKbkM3NUZINVpoKzFNT3huS2dLMVBR?=
 =?utf-8?B?eEkvWWpYblpCdzBoRElpcWt0enRhSkZCQUdQNXRaOVl3eWdkb2dpWWU2Umg4?=
 =?utf-8?B?T0FtaFpiL0k4aS8wMHE0akJmZkV4YUNnckZwUklKUUQyNVZxanE0TWpQQjIy?=
 =?utf-8?B?WmE4MVgzdzNvbGt2bzFjUFU0dGxFZUx1Z0FBbHpsTW80WVppbWpKdnBUTlpJ?=
 =?utf-8?B?UkZzV2NIZFdVY01ZR1l6dXFJTkZYeVFoSkxabFkwZnUvWThmU3NXUEZTK1I5?=
 =?utf-8?B?N0RlWWRCZk0yUHFLd2FkVHZpb2RzZHVVOW1YUXcrcmZQVEJES1NuQXFBeHRL?=
 =?utf-8?B?TkRBUGZIZmtHMWFjQkNyK3RKWmVsQnN5d3RyTE5ibmFuSHRSaHdIM3N2ZFJx?=
 =?utf-8?B?WnkyOVRmb0NHaFRlazVFRU5SM1VJWnFWUkcvcVlaaXRUVEJzUTVHcjlibDRJ?=
 =?utf-8?B?MjQ5dmpRdEcwaXV0RlNnUDJJa0Fxa3B1OEg1RnVUcFdXUis0VERBeDVwcFI2?=
 =?utf-8?Q?V3EIxETMdYZf+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXU2dGNMT1Rxa3E0UDBuQWFnTzBuZGtpNXJFSCthSWN1MjhkS3ZrU0lFYjRD?=
 =?utf-8?B?Z3NaMVhhaWtSR1FXcTA4dDg0VFF6TXVqRU51V1JNSlVKeVVsRW8ySEgvUXJp?=
 =?utf-8?B?WmdPTFBnb0JpRjhhbUdVa1ZiSkxMMWp0Skd4U0sxMlZlWmJSQ0MxVy9BSjh4?=
 =?utf-8?B?WkRaOHdQNlhzMDljQitmWkwyQUZramVwVGF2YlgvOHZsNHBDTUNDSVRoSWxt?=
 =?utf-8?B?Qk1sUVZEeXo1WEJSZFZjRzVoNmhXN3lPeGtwSk9ERHNHcENaM0p6WlptYUIx?=
 =?utf-8?B?ZGxxby9FOXA5U3lHK2JUYzcvcnptdTYrQXovVitYQThuZzg2alNpWmlUNzFM?=
 =?utf-8?B?MDFFL0ZEVlpYVStvdFVRMDR4dU9rZjZzQllBVGdVQmRqWWZ1bDVSbVBieG5S?=
 =?utf-8?B?Y0VDWm5oL2luL0kvSUlsNXIrVGZSU1d4NitqYy9ZMllyRjlHajNFTk1YWVJJ?=
 =?utf-8?B?QXJOR3hMQ1RKaVRQMzVmUHBkMzc0bkNWUWpRQjA2YUUxZE5zaWllVk8vaUZS?=
 =?utf-8?B?YmxFM05YZXJnS1RzWndMVSs4bEtTSXkwUlJOSEdIMjVFM1pNbVA0ZHJObHl2?=
 =?utf-8?B?UTNOR1RpZ05zL1plVklKRkp1OXpQenJ2TUVSZVZHWmtxeVF6M3VVWDlMMVFQ?=
 =?utf-8?B?TVFKRjhjRUNRQ1dhU0pGdDd6aTJObWRuRkoyU1NUdER0TU5jRTdGcHFuQ29D?=
 =?utf-8?B?eDJEWUY0UEFvZXo2NmdlVGRSWU10bFpmbDkxa0tNNGxkRWlTTDl5Z3BSTkJq?=
 =?utf-8?B?N3lUT3orSTh5KzFtZzc5VGU2bDJRdVNkc1NEWE5VWmJIT1lLVFMxbDdZYmtZ?=
 =?utf-8?B?ajZKaU9IejB0Q1llYzdGK1gyeUtTbVh1S2ErM2dkeVdoODFIL3BiNHhYNTVH?=
 =?utf-8?B?b1RkOW4xMlMwZFplWXA1WmxoR3doeWRQUWdET1pxSlluai80STZwOXlhVFR6?=
 =?utf-8?B?R0xIQlArWldneFBER01xaHdvOWd6UnQ4RHpJSmpkNUFkaHZWalByN215MmVq?=
 =?utf-8?B?Y2J6Zm41cGt4SkhGOVRBZ2lPWmlsTlo1NlFrVXJXZXJldWdMcDE5NFppR1Br?=
 =?utf-8?B?TTJmOU92RUN3Y2hxblRNdlNocXJKWGM3SVZKdUNRV0NYNVNGcTVtS2FaSi9F?=
 =?utf-8?B?dFRTckJySzNKT3BrQ2FWdEJYY2FjeTYxOEdiZWhUZXM3TDRMcCt5c1hkZlEv?=
 =?utf-8?B?VFRJUWFxZzlyYzJaM1NPSUdNVnBaNkpBZmgyS0F4UStabmRmd2tMaTZIa2ND?=
 =?utf-8?B?ZUNqZWN3N3dVL3RSZU03cldHaGZIWHJHNEZLeXpnOUhxVVcyTll2aGZ6TFRH?=
 =?utf-8?B?S1dQbms5Ti96ZFFCMDk4cU9vV3pjaHo1blVkUHNxNVZlQU5yWkhQUFlyT2Z4?=
 =?utf-8?B?Z1I0TEJKU04xN05qbnkzRnFqVDNpVXh4YlBkaHEvTk5DemdIcktjVHIxeC83?=
 =?utf-8?B?WVV3Y3FTNGxMT1E4UUVYL2lTT09OYkJOeTdYVnR4clJTVEZ4ZFNQNkd0amlh?=
 =?utf-8?B?ZUczUUlkRWV3ZGxsd08zcW1HK2RiU2owZlFhb0d2WlhrZ2ZtWWpBc0hvTDYy?=
 =?utf-8?B?OTJFTXVYeHNHRzFJQnAvS0tNQ3FTSVg3NGRjaU5sWXJBNXRFSitXZHRkSkZy?=
 =?utf-8?B?aENmY242TTVOM1MvWHpyRmdGeXJzWnNFb1cvRFlnT0Mxd2pOU0xGaHFUN0ZU?=
 =?utf-8?B?VW11NnpaZW5veDlTRkhPak5yVEZGc0pDVWhoa2RrQVMrM2wvLzdkSmg1aUMy?=
 =?utf-8?B?WHR1cWw4UWl0ZnZPTjZ0YzNYbWdwaUZMR2dmUVZ1RFQydEF6VVVmTUpHYXRN?=
 =?utf-8?B?S1J1N0RxM2dVV0RqV25PZVhVc1lYamFDL2tlYUhPeklic2M3Qk1IRHQ0aEVY?=
 =?utf-8?B?TmoyK3NYYWxyTTZYdGtoVFYxU2pTNjhjbitiVWx3Mk8vbHNCNnRXNUgxME5H?=
 =?utf-8?B?K2tUS3c3OUdqTkg5Z0ZpSkpYWUVwODYyQ1UwZmF4b3N6aDYvQ2RpenpmRVps?=
 =?utf-8?B?cVZUank1TFNIRWxMY3AzMnBEUkRjRmpxNXR1RG55RG1lZkdtUXpycklMUkNI?=
 =?utf-8?B?MElzSk1pcTBtRlQ3L1crUFB5TkM2dENFVThrZVY5TUkzSnFMZlEvVWcrRE9J?=
 =?utf-8?Q?s4hITt/WCBHE1YVaCq8d94AFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd316aa1-de7d-46d8-65bc-08dd28b08074
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 09:01:09.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkaVuj2bFzupedmObNm5vP596l69VWYDjnrQQQsSL5rw4NrNi1Rp2PpcVx03/dFDrFXeld1m74Sqijqnggno+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271


On 12/27/24 08:04, Alejandro Lucero Palau wrote:
>
> On 12/24/24 17:22, Jonathan Cameron wrote:
>> On Mon, 16 Dec 2024 16:10:21 +0000
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Create a new function for a type2 device initialising
>>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Comments below.
>>
>> J
>>> ---
>>>   drivers/cxl/core/pci.c | 47 
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   include/cxl/cxl.h      |  2 ++
>>>   2 files changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 3cca3ae438cd..0b578ff14cc3 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -1096,6 +1096,53 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, 
>>> enum cxl_regloc_type type,
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>>   +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>>> +                     struct cxl_dev_state *cxlds)
>>> +{
>>> +    struct cxl_register_map map;
>>> +    int rc;
>>> +
>>> +    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>>> +                cxlds->capabilities);
>>> +    /*
>>> +     * This call returning a non-zero value is not considered an 
>>> error since
>> Error code perhaps rather than non-zero value?
>
>
> Makes sense.
>

I think the right way to solve this is to have a check for rc being 
-ENODEV and returning 0 for that specific case, then returning rc for 
any other error.

I'll add such rationale in the comment as well for v9.


>
>>
>>> +     * these regs are not mandatory for Type2. If they do exist 
>>> then mapping
>>> +     * them should not fail.
>>> +     */
>>> +    if (rc)
>>> +        return 0;
>>> +
>>> +    return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>>> +}
>>> +
>>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct 
>>> cxl_dev_state *cxlds)
>>> +{
>>> +    int rc;
>>> +
>>> +    rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>>> +    if (rc)
>>> +        return rc;
>>> +
>>> +    rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>> +                &cxlds->reg_map, cxlds->capabilities);
>>> +    if (rc) {
>>> +        dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>> +        return rc;
>>> +    }
>>> +
>>> +    if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
>> rc is 0.  I doubt that's the intent - if it is, return 0;
>
>
> Well, if the conditional is true, it is the end of the function, and 
> we know there is no errors,so yes, return 0 will make it.
>
>
>>
>>
>>> +        return rc;
>>> +
>>> +    rc = cxl_map_component_regs(&cxlds->reg_map,
>>> +                    &cxlds->regs.component,
>>> +                    BIT(CXL_CM_CAP_CAP_ID_RAS));
>>> +    if (rc)
>>> +        dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>> +
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 05f06bfd2c29..18fb01adcf19 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -5,6 +5,7 @@
>>>   #define __CXL_H
>>>     #include <linux/ioport.h>
>>> +#include <linux/pci.h>
>> Use a forwards def if all you need is
>> struct pci_dev;
>>
>
> I'll do.
>
> Thanks
>
>
>>>     enum cxl_resource {
>>>       CXL_RES_DPA,
>>> @@ -40,4 +41,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, 
>>> struct resource res,
>>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>>               unsigned long *expected_caps,
>>>               unsigned long *current_caps);
>>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct 
>>> cxl_dev_state *cxlds);
>>>   #endif

