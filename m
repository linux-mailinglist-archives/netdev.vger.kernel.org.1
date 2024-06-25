Return-Path: <netdev+bounces-106617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF03916FA4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAD5284C2A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C06176FA5;
	Tue, 25 Jun 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aC+M3nMV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B6176223
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338265; cv=fail; b=EPGMW8l9om642eSGYfnKl/fVga5Z1dzecPJe/RHiL8G45a3Eicw4pqNi/5vvuvfQeNXk5daruY6Jk1oMlA3ul2DYvVvzsdYQ6kZxfqfzzCxlzzQGdTg0XbfMnb+h3i2ELwOe/xh1QjypNJS8Mj/gyJacviX9Y+gGpfgr9X1r0Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338265; c=relaxed/simple;
	bh=KBa6KrP++nhtGiOqp3livP90EIEC8jrfm9YKSamdoWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aoa8D69mxn5qP94Jh/vbECNWmtgnim8IHqpIMLjS3H6l08LGOxtgkD9jSn4JKRQnQicWt1g+1FKE80nqr32kOelI+aoLc5qvBFsTMn9rKzEzGkE8jpLeEvJL2HhcRpnRMLQnYpLUJSdP46QPmrQn9SVYkzeIgjKc+zVDOQOFv8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aC+M3nMV; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9sScxG8jJ2zuDTOx517ZFSLl7OApiMk1Sm3uVupmwTLeHAVE18euKNd3fl8dP0cfXg2yv5kxiki6cqRZ9Y7orlP1TEDDMyC2We6kmqPUvG0fTdz6UTR2R4xMBMZIJnHIPBZiyHOFSgdiU9jF926WuakTBGoXmNaBz1otwnjEs6GVevEQGqkJxTJT+pRiGAS2NM/UTcNS615UeZXYSJ72IUZFiAKTIO/kEGXcE/zZN0siiYlDun4GuSHs/RlrSU2LtHZeRDBBiG5XHB/NREvvfrVULx6QUlMNwY73p7Zk1BySAqkgMWxhOACKPiYvOTRCG8Te8Eklvfbh0/GJJDYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+WAW7g/9xZmNomJRgOjReA8TKWKGbFRbUTv2P4tKMk=;
 b=H8ove5wUva4X0ezRUVYxUOva1SOHDcI/Gf1Y0o2B3jwRtIPr3Hj6EEtYQ/z6bEuJ8/hfDtjnOC+otl9LbptmoehI5nOZEKj5HFgfiaO+MObhQ2uFB3joxTz4WQBYB8mr9qkOjtMp1Ud+vyZ82Mx9c9sVSA8RVYCtGA7LXyadANadHahoIiRxP/8Zcy8wNqtr7C/647GYkkbTVQz+w077o31nuYOPlXdF/rr65J8J+FjwhVMLxQglngpdS/Vn4Pt2Hl8ugPulAooH1+O5i8VuE8m2ojeJJwxr1pDKDu7cYewxOpsgEcCKis62jXbmNjFBIMyJYnfFMpu0yCkur21wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+WAW7g/9xZmNomJRgOjReA8TKWKGbFRbUTv2P4tKMk=;
 b=aC+M3nMVo4n+MnSuOjxtc5CR5CUxa3NLfVHt4aBoFQ/s5ASwybbMwF55eUGELOZOsrRtA8j89U6c3i7wGUyBlRUsiTWRk/M8Qx73mcglXQNY2KPtGDyBaMdcmcOR2vTFCEg1Oi7DQ1vMZ3FENDy0Tim+8Ad5Dcy/fA7WWJOplSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 17:57:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 17:57:40 +0000
Message-ID: <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
Date: Tue, 25 Jun 2024 10:57:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>, richardcochran@gmail.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Simon Horman <horms@kernel.org>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
 <20240625170248.199162-3-anthony.l.nguyen@intel.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240625170248.199162-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd34995-fd27-4c11-021f-08dc95404e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekdTdStMbmF1MWhCazZNQkk5U1NkRE53bWR1emN0aHBObjRQSXlTQ1ZUNUdI?=
 =?utf-8?B?MEZFL3pUekhhNVViQ29KNTkzbmJsdUp6dnpaWnl2MEY5MnRrRFBaOW1nMDdV?=
 =?utf-8?B?ZUdjVU9RWUQ0czc0K09GcHB2RmY1VUpBSTZPVTIwSDBSbytOdlBPSHl4emZ3?=
 =?utf-8?B?TEY5VDJUZ3gwWndXeFArSU9Jdzdwc3IrR29pbUJWQ1RRalVFQzMrNnBzNFFw?=
 =?utf-8?B?QzViclZLcWlIMEZNS0U4QjM2UHB5N0djVGZiYmN2L2s5NjN6ZVgwWHB0dWRL?=
 =?utf-8?B?cEV2d0l5c3dGTFRmdFZRZUt2dFhFWi9lZ1JpOW5aZmtCUEJjN1JGSlM0Zlo5?=
 =?utf-8?B?eDJSYzVNUnNLaU80cC9Gd2phc1JFU2pHTU1NdjhOcDJzVjNLd0RoZDhxNzY3?=
 =?utf-8?B?TW1QcDlFOTJOcWdLUW9EV3RkeFdLTWpmNE5RcUR5VUJMblIreWtxZWNQelF6?=
 =?utf-8?B?ZHVMYlNFc2IrOVlqdGxNdjJKVzFkdjFtQzJ2bktDaVNUQ0F1bUkxRkhxRlpQ?=
 =?utf-8?B?TXN0T0c0cWxpR0YyNGs1L0Z0NUZraGxaS29ZVXNNVTU2RHdJMVpuSTcya0lq?=
 =?utf-8?B?M0gwVHdrQnJ6ejFhanBpU3AwT3pvd3lKOHl2RVg5U3pvK0tRdzNtamhRVURT?=
 =?utf-8?B?Q3Nwc29qODJKOUkrUTg2QWZpZ0xyUFBCeVlHeXhOSWpHZTU0ciswQlRZSXQw?=
 =?utf-8?B?Smg3ajR6MG4zOHBUVTExOC9GTXVIaWZIYXdKTUhWQVpOOUw1bm01bm9FS1JP?=
 =?utf-8?B?MzVUYjkzelc4aEFoRm5wcGhxQ2dSa1ZpSVZPcExsQVp3OXJ1c1A2NU1weFlv?=
 =?utf-8?B?WW5ZWXpjZm04UjJoWGdEWWhhZUgyNDlzWXI1emlLT3VkdElFNDA2Wkw5eXFU?=
 =?utf-8?B?YkNVcUk0WWZ5TGh6Qk01bnc3bHBJTk43WFpqT0toSGMyRDI2WUc1OVZaRzJ1?=
 =?utf-8?B?ZXluQTV0MGUySHlQaTZSd3h3ZHh6SVVLN0Znd0J2TThMU29JMGROd1FwTjdM?=
 =?utf-8?B?TGxrUmw4SHJqSjJUcHJiNlIzdmhqWk1sVG9RZzZkRnpvZTFaRkFpamR4R1lt?=
 =?utf-8?B?WVVEUERlTzFPa2RFb21BNGtJOUVnZHgzd29xQzVvTXpaSjRCR3N3RlRwZTN2?=
 =?utf-8?B?Y0ZRSWdWblBOLzlVMy90L3dmWDgxVHkvKzRWeWsreGtiR01KK1dOYjJ5aFdz?=
 =?utf-8?B?L3RiUW5TV0RLbVUvc0dBaExsaHNsSzIwaHdubi9jWTRmaXZRRHZZSVdUTXNs?=
 =?utf-8?B?eUJ6NHNwRjExUjJjRWE0ZTZmVEdYWERnNUVleVNNMGJabFdiR3BQYnhuY3Z5?=
 =?utf-8?B?VDE4TmZtRVBpSjVFejR0anhPY0tlcnhhNmFkOFB2d1dkc0ZWMDVBcWxsSzIr?=
 =?utf-8?B?dndnZDdsWUZFZnNjQWVGRjlZWlUwckg3WlFSUGZxRTZ5cjhEekk3c2ljMDJV?=
 =?utf-8?B?R2JGMGkrWDVVckpXMmFQVytSYkcxaDlxZEx2dWhwRXhMcFRiZGRhTXd5SlN0?=
 =?utf-8?B?a1gybWd1T2hZVTVvVnpKT3NVU2hoVXE2YWhyVzAwNzlPV1lDWHVRTElPMGJT?=
 =?utf-8?B?aVlvdmhmVWNKSTl1M2FiemxSYkdWWWlGWVVhdUxDVGVNVms5Lzh6MXF3TzZT?=
 =?utf-8?B?MTVMWm4xQTFtYkc1NlhYWU9YeGViZTVwa1ZVTWRvTHdPL2xJNXBRdnI0eHNw?=
 =?utf-8?B?a29SeFJjK1k0VG1sNjZhUUt4ZlBka0MrTG9DOGh3NjV6QTI5N2FESWZFSDV6?=
 =?utf-8?B?bW9GNngzWWNJUTQ1dVc3ZTlDL1RMMTFsOE9EZGRsYi8zOEdHRkJqcnFHaUlS?=
 =?utf-8?B?TllLTWhodFNiTENwbFc5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGxRVnptb3ZYbklqQ0MydFUzY1B6RzhhUGVYWE9EUXRPZ1B5YXRRV1QzU1h0?=
 =?utf-8?B?TmM4Nm92cFhEQVlUSmZXVzlHUFowQWZNTmZGK3Ezbm45N3Y3RERlclJMVm5O?=
 =?utf-8?B?RGd1RUs0Z0FvUDVRZ0ZGVFNNRWhuK05tUThSUnBIQWpsOWtpTnZEUzVWejY0?=
 =?utf-8?B?NDhFREpLRzZIKzR3aUpMYzlvaE1hNTlteGIxdkpXaFJUTkFWdGxwdXBta3gz?=
 =?utf-8?B?VG91azBFRVV5SCswamFmOWVEMVdpaUE1S2ZmcFB1WFd6b0QvYXRRb0Q5UFlR?=
 =?utf-8?B?dFN5ZjI3YTZFR040TmZKVGx1aU82LzEwQ2RrbUs4aDN1YjcrMnpFQXB1WmZ6?=
 =?utf-8?B?M0lzK2hhK3RUdzdVNklTUkNQaGxrYy9XRWFLZVdRdVMvWVRrVWdpcXgvT0Ev?=
 =?utf-8?B?K3Jab0NXRloyZnNocmNQektwSGpra0I5dnRoRHlyMmpuSURUV3BhS29TYTQ0?=
 =?utf-8?B?Vk1QK1l3cGpZcFRJSUNtQzFHTmVZcjdMZXN2K29QVFVhejIxc3pwdE84K1Zu?=
 =?utf-8?B?czhPZnNRUzhFSmVaemY4Ty9XOUJQQzdGL203N3lMMkdrVDJkYmFJT2l1aGJZ?=
 =?utf-8?B?WVFZb3FPOGMrT0FvU3FOVUFnOXYzL3ZsZHJaaS9GbFlRSXhOeFJpTlFLdlVq?=
 =?utf-8?B?Qnl3Z1hIZ0dSM1hxbmlFanBrbEZqaXlkZFVSOVB2c0lBd0Izd0pnMytkODgr?=
 =?utf-8?B?SG1iZzJlSmNPWkd0V2MvSXAzQWlDRHVZdGx1bTY3MHFJT3kwb3pyUDZxSG40?=
 =?utf-8?B?NkdScG4xYUkyNnpGU2c4dnpYWUNoMzV1NmlRdzdsTWFqVk1jQ3BDTXozdHh5?=
 =?utf-8?B?ZVNRb1V5MDZVV2tnYmI2dGtmY1hYOVdjeE1SWjY5clRSSHQ4TDhWZTloN3U1?=
 =?utf-8?B?NmlsZy9hTzVtYTVZcWY2bm14bjM0WmVudFh2a0ZzQy8raURRVzNCTi8veno0?=
 =?utf-8?B?VXN3SEI5R29ydUswN3F3Y2Z6bUV3YkpOa3BnK1NIY2pUK1ppeW12R3JiMzBG?=
 =?utf-8?B?dDhhUmFhcmZzU1pybHpjR0tpTTdEcWsvOExrQjNSRmtlMTlGYytScU94VFl1?=
 =?utf-8?B?OTFWckdVVmVTSGtLQ3ZncXJ1TlFBcFJKSXJZcGFiWlowM2hBYjlnZnFBeGFx?=
 =?utf-8?B?ZVBJSHhGOENURnlYT2RGWGlYbndSRkxrSVpkbzVUMFNRSEh4eUMwWU81UDF2?=
 =?utf-8?B?NlZhQ1p3YlRWWlRHVVV3Q05GaU5SajhyWjYrUFNRdU81UXc2QkhUZC9VRTY0?=
 =?utf-8?B?bEFZaWFjNFJ3MDRHK2d5NGw2dkNZbWdHRHY0TTJncWo4blZ4WTQ4Yy8zcEhX?=
 =?utf-8?B?NjZmNk5zU2lQcjNxZGVBT2I3bTBwVHowMDJETnNhMER5M1QrcnFDaXNQd2Jr?=
 =?utf-8?B?Qkt4aHVoNnlpeE1PbjU0U0hCeEdJZGxoR1JYVUxwMDM3dlk0Z3pVaFU5UVYr?=
 =?utf-8?B?UmJ0NFpNdkpCZXRLdnRjYUE5QnBqZUhydURrZGxqaVAyRjJlaGNWZEY3SVRz?=
 =?utf-8?B?VWxVVXpvL0NtR1ZnRVhKYkRoMWtoM1VuUk5VMk12R2hxOE5qREJZRG1jZUND?=
 =?utf-8?B?NFgrSnczdDlMRXd2VmoxcExwbWZ5dVBLdWY0SkM2UVhyb0JCY0lHRTJGcVhy?=
 =?utf-8?B?a2kxcGYxT3BpcVpuak0zb0NtVTRRajAyT2Q5bTl4ZkpudEdOMnNaK0FzSkNr?=
 =?utf-8?B?R0c4dlJxdTRtcGo1UXQxOVFaNjRsNEZzV0lJeWZaQlhFY3pNTnVVN1pTTHF0?=
 =?utf-8?B?WTJHMmQrOFltcmFrNHJzdVRGY0xBWE41SGtobk9kZE5CYjJSeUpReEdqOXYv?=
 =?utf-8?B?a0hZUjdaNktJNnlpcWY4MTQrSm5HaXNNdkpyekJKWmw5TTJrOCtIU1ozME9x?=
 =?utf-8?B?bTdiaFNybk5hNVBUTDJVc2Fnc2dVVldJcG5kVkNhQkcyY0NXQStwZFJEZmYr?=
 =?utf-8?B?VFcwSW1pNGhMZ2dqQTdqak4rNU54S3U0WGNMVWNpcEQ5U1FVZzBCS0pieXVS?=
 =?utf-8?B?QUtUSU1teDVKZzFDRENRc2tXYUp1V0NYaEJJeHNhRWNUandxNkdjenVSWVU5?=
 =?utf-8?B?S0pvdWk5elJ6citLWDRpTFBxMEpaZ0diSXh6TE5jd0tMUEZBNExvRm52T1Y1?=
 =?utf-8?Q?CrolYVzOlsVVuIMZxAVuLHdyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd34995-fd27-4c11-021f-08dc95404e40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 17:57:40.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oayyiEk7DSXJx4c0/R7e1sRKuGhn6V9GAxO4+k2ZjCarUGWcaACrpnccKtwXAqEFsQGRoISnKUtpC0H9hSwuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

On 6/25/2024 10:02 AM, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_extts_event() function can race with ice_ptp_release() and
> result in a NULL pointer dereference which leads to a kernel panic.
> 
> Panic occurs because the ice_ptp_extts_event() function calls
> ptp_clock_event() with a NULL pointer. The ice driver has already
> released the PTP clock by the time the interrupt for the next external
> timestamp event occurs.
> 
> To fix this, modify the ice_ptp_extts_event() function to check the
> PTP state and bail early if PTP is not ready.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index d8ff9f26010c..0500ced1adf8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>          u8 chan, tmr_idx;
>          u32 hi, lo;
> 
> +       /* Don't process timestamp events if PTP is not ready */
> +       if (pf->ptp.state != ICE_PTP_READY)
> +               return;
> +

If this is a potential race problem, is there some sort of locking that 
assures this stays true while running through your for-loop below here?

sln

>          tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>          /* Event time is captured by one of the two matched registers
>           *      GLTSYN_EVNT_L: 32 LSB of sampled time event
> --
> 2.41.0
> 
> 

