Return-Path: <netdev+bounces-119044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D36953EB0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F83B2830C9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9ABE49;
	Fri, 16 Aug 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQkeSzSJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7C8C07
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770215; cv=fail; b=G/JDPbows9MpyclrxXZDShBvhkSvUg/bbUEzgCyRS7y5J34LlOmzN1D79FDJWtsHkG8GIkYtSU0YilC1IEgcx8juA/uaSQRRcxsv0yfMLZhxSHviRB8saoQM4l72ed0oKCAUHQQasc+Zcuzb9DtAQxv92GSVpviXYL+/OT7G3S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770215; c=relaxed/simple;
	bh=XeyoDbmoKjlNeugHEjYWbCycldtStlogT78uY9fCsn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUubNuiqpluEJqvIZ2RV4NqZA5H2Jg5HLR4lpfNZ8icm6gnVfE0UP6aLVPuVQZiKWjyPmpZk5wUS90fLOsma6rKsMkZpyVgf439UsAyWNaxFL4u9K2bN3X3MXJWIxkmerJoBa1ONszzy+5LgG8+XcFjB3R60m7c3iSEy9iCz+W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQkeSzSJ; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjPsxRDeyll+kjfcI7vZ70IGVtcppOAdp+Vbw+x8tQt7F5RQa+uQNc8FZXwbGGjKMB/okfOHxFybjMHlmzXpNevQc9FaO8uVfVcK6l0C7cvfdzsJ1Rlx4582hAxxDCHImi0EKGRKgyREww+eTxgVCIXXA+k+3soQf6otu4GUXWZHF3sVbSMnab2vV0z2DeCpuKhI58PmocggI8xZlsw6xBOnPQK6Ijc4hM1V4NrrjD0ib8PrhEf86+JXPv7R6IFZa8To0CkBE/8A8l4NmCamG3tD65W2aKLWxsAgQjZuHfVl6+w0L0TAdQ+9hdHLrTZtBsdPSYfLvLPur4ANuNdlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjIoEESReHFFT5tamK8+yBhYHb2OlBvwbTvdqp66Dv8=;
 b=RTQ/oJSeO/rhS+mJ9Wuft+qMiRu0OrAFWOWfAW56eSp1EzpnxTqnARVLEiC0P6yoDfNG3gtozX+W+QNf7cS00YT7RXT1Pm5nMMnX5g68ROXoMJKPMnZ70kuRC/2gKWcyX28jynMwIpR5QJkifIou8bAt4rhsF+Iqx8QJ8ZR5NSdLhepWQg7bvqU0EBM1bUVTbj4xkFACTlOGwNvg9pnPOuZXzd75PJiBAf2RwTpMCzPXlinfFm68zhK0M9kh1oUNQozxqglxxDctD+ZztCIYIpknDMTXGOdBHIySTFgUEUMibeoxNHMVEyansZ8M3qm/IjjDz/iMaogpsWXMHXM1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjIoEESReHFFT5tamK8+yBhYHb2OlBvwbTvdqp66Dv8=;
 b=hQkeSzSJuWBuTNUgvykRiYEHjk4GyUBSYvYvlaM4coxaosmnZYimvJjm7viloOZQEzahvP+AYkekNxpUVO6LAHtEe/FdsD7/e0eL1LmOx/zGuWHwbHrl31jJo3Zy/+veTEGfAPAfk6DoORfHgUV7JtDTs0/Diae6hMxxTpXxjjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Fri, 16 Aug 2024 01:03:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 01:03:28 +0000
Message-ID: <a40578c7-6284-437b-95b0-9f848e76e052@amd.com>
Date: Thu, 15 Aug 2024 18:03:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yuyang Huang <yuyanghuang@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20240813223325.3522113-1-maze@google.com>
 <a4f73bac-12dd-4fbf-ac56-0c704563d0c1@amd.com>
 <CANP3RGfarvhSFm8UhtJC2gzgigt2wUcBQAoVC+ZRP7zCXH=wtA@mail.gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CANP3RGfarvhSFm8UhtJC2gzgigt2wUcBQAoVC+ZRP7zCXH=wtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CP5P284CA0103.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:92::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 92937156-5368-4e33-0bd3-08dcbd8f3cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0d6VzNYby83bkIrMEh0aFZBQ1BLTU5IUjNhVTk1RGpMVVBvcks0Y0QyWlF4?=
 =?utf-8?B?STV5MkMvMkp1TkZXb2xydWF4WG5ldzg3aFNacFA2OUlsMkUvQzNDZ3RBTnZq?=
 =?utf-8?B?NnBsNTBCQlpVWXlOTDZ0QVlNV3NNaXpYN3AzVWk2SDRDSW0xZUhIOG9kT0xa?=
 =?utf-8?B?ZmNXTzJMRUNDR3dhM1lKZ3FYRXNJNFNNNWE4RzV0ZE1pS3NpMFdFZ0RQQTZm?=
 =?utf-8?B?c0dZWWxlVzVKTGFhbVR2UXRFdnJ5dHZPV3lKRW5WRXp1RUxic2lJRXh1WStT?=
 =?utf-8?B?cmZGbURPVk1TQXU1Q2VyemtOSE9LMzk1NXFNelhnancvMGxCNlp0cFVqcFBC?=
 =?utf-8?B?RWhTTjcydEFOdEEwYmdqM0ZwT05NRWRRTG1XMmd3SE9ZOFQ3QlArbHlLR2hT?=
 =?utf-8?B?RkNnckpiWk51V1JNdjdtRUpuYW14TjczcXBibXovdnpzTEV2MmtpMUJybVhP?=
 =?utf-8?B?YlB2ejNYejhNREtLTkM0a1NkdzNqU092Q3FYVUd3UjdTTzFYRzFZMDloYmd4?=
 =?utf-8?B?OWQxWGFTV1dab2I3VlhvR2FjWnhOekJpMlRXdW5QUmZQeEtyR2NXTk9zQ3do?=
 =?utf-8?B?dkM5QWVkbDRiQlphV0YxMER1TGRtaXdEKzJQVlBKSXFEd2RqdkFnWExUVUNx?=
 =?utf-8?B?SVNCT1FnWnhHWnN4aGc4em5UcnVlL3NpQk9xZjZsN3A1aXVsWU82cDU2VGdr?=
 =?utf-8?B?NXJ1aTVFTU5OSGRCRFFqWENDYTQvZ3Q0ZEMzK0owa0dTLzFud2NlN29sQkdV?=
 =?utf-8?B?OFliWGFvOWNaYnh0Z2pyUFdXYjFzRXhjZHB4M2kwZWZ4emNsYjVtVngyQVdC?=
 =?utf-8?B?bndUQU1jd251R2pDMWI4RmtTN1BVQmQ5aTdRR2RrSmxZSUNrRmtxYnc4MVl0?=
 =?utf-8?B?d0FVNWo2NU5GK0J0VWI5M1hVWjRJQUFKUTd2ODc5UlRoMmJZRlJtbTZLaTho?=
 =?utf-8?B?WktnampwOXJ1SDEvRDNwQkZvbjQ3VStmYXFabTRiZ0kxV1BRVXE3UzZQMXlL?=
 =?utf-8?B?bEJZcG00NGFnT2s1MkpRUGNXcDAyd05tOXV5RW14ZGVqSFd0TUNaTVlQTS9Z?=
 =?utf-8?B?REhERmNQZ3d0bkljTjltcjl6VFcyd1hDSlRKUS9OQXZGOXlEY0Z4VkpPREpo?=
 =?utf-8?B?dmNycloxaFY5aUtyZWZqZGJBdFErd3hNRWxJbGF5MkdJYTBIMEhxbERSSENE?=
 =?utf-8?B?SXMyazdaNmpsbUp3Y1NkclRyN1d6WnY1azFPZWdrenlTUjZFeDA5S3c0dUpI?=
 =?utf-8?B?RG5CanF4OWszOTJmVWpZU1lEbndyT2NLVm40dks3WUQxTXlBYkp1amlCaEZr?=
 =?utf-8?B?T2pVa25maU9XV25LTUt6YkFPRXA0cjJTRW82VEZxZUVqTGtHMjNoTlZqQjRR?=
 =?utf-8?B?VDd6eTJxSU4vTkNmR3J1cHNJNzErTW5WbE5acGJQTzd1NDhZbjIyRGZxcHpK?=
 =?utf-8?B?OThBVnFSV2NFS0duWEg5cjJpZzFFM0RwQ1JqZG9PN1JjdkZBcUJvVVRYb2N3?=
 =?utf-8?B?TzJqdXlNK1VveG1VZzFUQzh2c3QzZ2hreFBPSFVPenY0UnBhZytFWkhiYjl5?=
 =?utf-8?B?R0ltSitQcGMyZkRZWjIzZnYrUld3T1N2MlYxYjB5R255dDhrRXh6M1c2Szhj?=
 =?utf-8?B?R2szLzZ3MkNIMmM2RXlNTDdhN2VBSnl2aVZyeHlHeVA3d1Vra2M0VnlVRDNr?=
 =?utf-8?B?R3BydGlJTVNGWDJ2akRISjBsZUpQLzZ0Q3lnRk5ETGdLYWVWZ2hiQ0REZ0Zt?=
 =?utf-8?B?N2tvMW84QjZhSTRWaWlSVmlyMWt1alloQ3JKaE0zS1FpUlgrSTlMSHNiYTdo?=
 =?utf-8?B?TmZkSUlwZ241WnJLcTdZdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NJa3NZWEVGZ2JSN1hwQVRjNW9DVzh5NkpBb3JLWnE4eHdmbThRSldqeXV4?=
 =?utf-8?B?VFFJSWxOOGFRdHk4VHgyOEk0ZVNSMnZoRGVwL1hPWVFVV3dQUDlPcjdJNWZt?=
 =?utf-8?B?U1hrcmxwSmFjdzEvODdYYTNaMzRhV2JHSWNaSlVteERadDRpYk1xYStLa2xa?=
 =?utf-8?B?WVJ1UkZ3SFNOdUZySnpMTXhwLy8xYUlVR1o4REw2ZWtsUG9VMmQwSjlFWGJ1?=
 =?utf-8?B?RGc1MldyZFNPSDJVOW1ham1yZGxHbXIrNk5qRXFhVjBxMit6WU9TWmFjeCt2?=
 =?utf-8?B?WmxHVDR5NG1yZGxCc0NyMTBvOUtXMFJCdXp0MVMvOGVvN3ZZN0JMOGg1QkNJ?=
 =?utf-8?B?d1lGWGw3WmwwWERwdUxTRGdRYXdKU2JjNll3Yk1BTkF6L3lOdXRQUnFLb2hN?=
 =?utf-8?B?SEhETUpIK1F6UU1LOUdlSFpwUEF1eEMydzhhQno1a2lSYTU4RmxheUVKMnIz?=
 =?utf-8?B?WTZ4K1N1V1J3OERxL040T1VhS1ZQWjJreDJDeEhsU25va3dFdkNCaHNvUDZC?=
 =?utf-8?B?bktoMzBITHAxNUNReE9oVVJ6RUFwUUFSZDkwcG94N2R5Wm5WTjFVYk5QZ0ZC?=
 =?utf-8?B?S09nVUNHa2ovOXE4V0w2MTJ2UUUwRDVpeUVzZmpFWVh5dm0yMStHeENvM0dQ?=
 =?utf-8?B?U3NOMmRQdk5Wc1RzNDNBN3VaOXl6UHpDY1pycW5RWXJFRVNQenVsYS9UdXND?=
 =?utf-8?B?RnFmYmtZZzhwcEt6RmYzSmxzR1ZKZFJhZnBzYlora25uZXpYUms5NzlxMzBs?=
 =?utf-8?B?SHJJL3BDaU5mY2VoUU94bW9haDk5bWRTMmROUFVaYk13Y2VreDRHMTdIWit0?=
 =?utf-8?B?RTIyYk9xM01rcFdFYTRCdUxIWkYwSWVpNWVkaURDYXJuUVozQm44QW9aMUVo?=
 =?utf-8?B?K3kzeEtJaEtzZGR5anNXeXM3Nk9tNlQzdFVWUWNobVpFRjUxOXlSUjhuZkdr?=
 =?utf-8?B?SENaR2VpbHBGSndIOHdQRTV5WEIzdm1SOGRjb09MRmM4NlhkOHArYi8zV0tU?=
 =?utf-8?B?dUZIT01IeXMrTHAyUFVFckliM1BCN1RNbXJORFN4cnMrU1VCdDlrd2EwejZN?=
 =?utf-8?B?QnFWWVAwYUNPRjRFU1Y0bkhOSStHL1FnUld6R1plQUdJcmVFTWJ1dzRKbDR4?=
 =?utf-8?B?WVdOanU1OXVSbExNS1dZL1NydjdXbEpKa0pWSG9QWjk0QlVwcXA5NXhTOTdK?=
 =?utf-8?B?N2JEL2lXS3VMMnp1R3Eyc1Bac1VoWjUyMURSRndCcmdLRk41a25sOXJ1dnor?=
 =?utf-8?B?YWpHSGRYN1ZrZXRTc0IzNzZXZmdMTThiUmpUQi91SHBKcmlTTFpqa25uVVRR?=
 =?utf-8?B?TjZ1bnNNUkkvTUg4YXhsMHpUTlEzSjRUaTRXOU51cGhmN3d6d0ttMTl0Smov?=
 =?utf-8?B?OXEvNVRLR1ZqdkdFZm9VSkdtOFdGYmZEUnVUYVFLNTYyM01qUnZMZ3NXMHM1?=
 =?utf-8?B?cnFma1JFZVRFT2RncUZIWXBwMkZoZkpQQVEzRjZUUENBSTM4QVBtT1BsVkJk?=
 =?utf-8?B?VXhkUmN4YkxKdlNmcjc5cmcrT2kxSEhFU095K1hoOU1raU91R20rT3E4SmxZ?=
 =?utf-8?B?NExBSnBSWWI4TnpsU05DTElQQzgwbTVieXhsKzBkU1J1NGYvcVVjYmE3WG80?=
 =?utf-8?B?WW92VitTeE8yU1hJT2JISWNxbHdOMHdNdnZRYm9KbHhNWjNUUWtJWi9HVStD?=
 =?utf-8?B?SWZBVytVYVMyYzZlTnN6b0kvSmdVeEMweDdtREhDSVllY3E3YmcyRnpEZVFu?=
 =?utf-8?B?TEpLRVo5aDYwZHBZWFk3cGxtRitld3NyZ2p0dUpGYjh4bnkxTGpURUZ0dXFk?=
 =?utf-8?B?SmptMzNGVlFIUVV4RHJ3aDNUaVRBdG05OW40UUZCd2NMSEVLbWZnOEhJd2lW?=
 =?utf-8?B?ZHB6ZEJjZ0dTMmxWNXkrZlpNcG5EUkxYd25ETTdDQi9xOWFYN3BNZXN5Sjgz?=
 =?utf-8?B?Q2w2YTZVYXFqYVJTb1g1UmJFU29nTm5GR1hpSlFZU3N4UXJndUxKSzJVWjho?=
 =?utf-8?B?bTE5eFFnMm5FNTlCdThUdWNjZVFJTFdNaHUxK0h5elhKMS9PRkVLak9BeC80?=
 =?utf-8?B?RGcvRHU2ZlMyU0RpNGtVb3lBb3p4ZVdrWGZlWjFYWWdLL29ablZNbngyYUc3?=
 =?utf-8?Q?AgPpxqLlf5xatOJH+cWKJSjCi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92937156-5368-4e33-0bd3-08dcbd8f3cc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 01:03:27.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fm2MepHmLRvI6Pzrq0V5iqySQu0ckaGyyLYd0HeNXIGTP3yvkK5LkpyVxqDS2jsl2jrUc2wHsibXIHMAx8Emg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

On 8/15/2024 5:55 PM, Maciej Żenczykowski wrote:
> 
> On Thu, Aug 15, 2024 at 9:13 AM Nelson, Shannon <shannon.nelson@amd.com> wrote:
>>
>> On 8/13/2024 3:33 PM, Maciej Żenczykowski wrote:
>>>
>>> In order to save power (battery), most network hardware
>>> designed for low power environments (ie. battery powered
>>> devices) supports varying types of hardware/firmware offload
>>> (filtering and/or generating replies) of incoming packets.
>>>
>>> The goal being to prevent device wakeups caused by ingress 'spam'.
>>>
>>> This is particularly true for wifi (especially phones/tablets),
>>> but isn't actually wifi specific.  It can also be implemented
>>> in wired nics (TV) or usb ethernet dongles.
>>>
>>> For examples TVs require this to keep power consumption
>>> under (the EU mandated) 2 Watts while idle (display off),
>>> while still being discoverable on the network.
>>>
>>> This may include things like: ARP/IPv6 ND, IGMP/MLD, ping, mdns,
>>> but various other possibilities are also possible,
>>> for example:
>>>     ethertype filtering (discarding non-IP ethertypes),
>>>     nat-t keepalive (discarding ingress, automating periodic egress),
>>>     tcp keepalive (generation/processing/filtering),
>>>     tethering (forwarding) offload
>>>
>>> In many ways, in its goals, it is somewhat similar to the
>>> relatively standard destination mac filtering most wired nics
>>> have supported for ages: reduce the amount of traffic the host
>>> must handle.
>>>
>>> While working on Android we've discovered that there is
>>> no device/driver agnostic way to disable these offloads.
>>>
>>> This patch is an attempt to rectify this.
>>>
>>> It does not add an API to configure these offloads, as usually
>>> this isn't needed as the driver will just fetch the required
>>> configuration information straight from the kernel.
>>>
>>> What it does do is add a simple API to allow disabling (masking)
>>> them, either for debugging or for test purposes.
>>
>> I can see how this would be useful for test/debug, but it seems to me it
>> is only half of a solution.  Wouldn't there also be a need to re-enable
>> the offloads without having to reboot/restart the gizmo being tested?
>> Or even query the current status?
> 
> Since it's a mask of things to disable, setting the mask to 0, or the
> relevant bit of the mask to 0 would reenable (assuming there was
> anything to enable).

That assumption is not clear in this patch, it only talks about things 
getting disabled.  Let's be sure it is clear that 0 will actively enable 
the features.

I think part of the issue is the use of "DISABLE" and "disable" in all 
the values - it tends to give a one-way meaning.  Maybe using "MASK" and 
"mask" instead would be a better way to imply both enable and disable.

sln

> 
>>
>> sln
>>
>>>
>>> Cc: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>> Cc: Edward Cree <ecree.xilinx@gmail.com>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Yuyang Huang <yuyanghuang@google.com>
>>> Cc: Lorenzo Colitti <lorenzo@google.com>
>>> Signed-off-by: Maciej Żenczykowski <maze@google.com>
>>> ---
>>>    include/uapi/linux/ethtool.h | 15 +++++++++++++++
>>>    net/ethtool/common.c         |  1 +
>>>    net/ethtool/ioctl.c          |  5 +++++
>>>    3 files changed, 21 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>>> index 4a0a6e703483..7b58860c3731 100644
>>> --- a/include/uapi/linux/ethtool.h
>>> +++ b/include/uapi/linux/ethtool.h
>>> @@ -224,12 +224,27 @@ struct ethtool_value {
>>>    #define PFC_STORM_PREVENTION_AUTO      0xffff
>>>    #define PFC_STORM_PREVENTION_DISABLE   0
>>>
>>> +/* For power/wakeup (*not* performance) related offloads */
>>> +enum tunable_fw_offload_disable {
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_ALL,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_ARP,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_ND,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_PING,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_PING,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_IGMP,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MLD,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV4_MDNS,
>>> +       ETHTOOL_TUNABLE_FW_OFFLOAD_DISABLE_IPV6_MDNS,
>>> +       /* 55 bits remaining for future use */
>>> +};
>>> +
>>>    enum tunable_id {
>>>           ETHTOOL_ID_UNSPEC,
>>>           ETHTOOL_RX_COPYBREAK,
>>>           ETHTOOL_TX_COPYBREAK,
>>>           ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
>>>           ETHTOOL_TX_COPYBREAK_BUF_SIZE,
>>> +       ETHTOOL_FW_OFFLOAD_DISABLE, /* u64 bits numbered from LSB per tunable_fw_offload_disable */
>>>           /*
>>>            * Add your fresh new tunable attribute above and remember to update
>>>            * tunable_strings[] in net/ethtool/common.c
>>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>>> index 7257ae272296..8dc0c084fce5 100644
>>> --- a/net/ethtool/common.c
>>> +++ b/net/ethtool/common.c
>>> @@ -91,6 +91,7 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
>>>           [ETHTOOL_TX_COPYBREAK]  = "tx-copybreak",
>>>           [ETHTOOL_PFC_PREVENTION_TOUT] = "pfc-prevention-tout",
>>>           [ETHTOOL_TX_COPYBREAK_BUF_SIZE] = "tx-copybreak-buf-size",
>>> +       [ETHTOOL_FW_OFFLOAD_DISABLE] = "fw-offload-disable",
>>>    };
>>>
>>>    const char
>>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>>> index 18cf9fa32ae3..31318ded17a7 100644
>>> --- a/net/ethtool/ioctl.c
>>> +++ b/net/ethtool/ioctl.c
>>> @@ -2733,6 +2733,11 @@ static int ethtool_get_module_eeprom(struct net_device *dev,
>>>    static int ethtool_tunable_valid(const struct ethtool_tunable *tuna)
>>>    {
>>>           switch (tuna->id) {
>>> +       case ETHTOOL_FW_OFFLOAD_DISABLE:
>>> +               if (tuna->len != sizeof(u64) ||
>>> +                   tuna->type_id != ETHTOOL_TUNABLE_U64)
>>> +                       return -EINVAL;
>>> +               break;
>>>           case ETHTOOL_RX_COPYBREAK:
>>>           case ETHTOOL_TX_COPYBREAK:
>>>           case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
>>> --
>>> 2.46.0.76.ge559c4bf1a-goog
>>>
>>>
> 
> --
> Maciej Żenczykowski, Kernel Networking Developer @ Google

