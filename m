Return-Path: <netdev+bounces-161161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64BA1DB43
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD203A4EFC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A918A6A1;
	Mon, 27 Jan 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V38Jrei2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF27DA6A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998808; cv=fail; b=T08NUS3HVSkbiPdijPdXl/Q7Mk/VLcAdfr6xdpiSR1sCDQ4G7HbAMhEAmjamCGJpL3HUciwgFC/yINh6c0zdoiedU77Un3WXTWVXWg7hY60mEqaKVfMo5NgVMMUOyPZM0QytEHmOXu86/SyZcZOOzRk+8xyTwd38DIwYheLqoI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998808; c=relaxed/simple;
	bh=zRgj1ADaDsidsM6GowwnFm9pbSBeRlurq198wTsDx2g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dS4PVo4imWY5MUvAl2jNEtHkMS7xI23tGNjsANtKZTzb+dedE5oHel17lY7feIvT/GVkrRgU97OZ5EMvpWDpH+mD+g149klMGAnmkU97zR/o1IN0IKiHwGuHgXr53vIW6pSb4A2b1YfMkCh4a9mO3BDx79iX6QL7qp+BZuYWRVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V38Jrei2; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk9DJEIE/5RUPUzuS6sydepH9c3EjKrhw6LEnfquFIATjqDvM+RSN3F/emN8bMIH0j5+1qn8wJ6vfZ7QPRvbYIVMrnm2pM7hpp/lDvq5q12a3IT5qHqx5aRlz2cjPYYm8HTnkKKWsgrd/cr1mYtg2yx3Ulu8CoZBg/h+uvyHOTUYjzTU6YQvP1Pp5nU2Y4Ia3+IHgC6kv+ulzuQCampIwVCg8aKlPky+H+5R9WcG05s/UVE9NUFjWaI91LyhrQuTw/ZpFtXNR9W9CZrRM+F93uA87ScVNw0P7bpxXtpIJIK1ndSBfwZhMHEtmcKxcRJG5+e3OEUlrleZnywfpD5ysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxvnvpjZPhhVBNtGr1GNShQu0aFDZEogNefdS+WoaRg=;
 b=GDP+qtGo4YEU3nbrZOdgZvjR9BTEDE00Tp77ye8EgZsUMITfTdRSL+MyYhPHUrghn4He9IyRetMoXiyBsxbPfqHJxlKDnpqlZRenWIE58fM2hizr4rccSl071bvqzXjNWV2hV9CtKznMT+aGZr1TStjqf+L1rMnSG4ti5Ls+arrs5w6BskF/wmfo9CoLEsInANuerkaqCTn4mnwY/iEgmNAmFqzoRtEiKj8Ay4S4ieupxgPxWn8aUfXJs19fCwTFzcrOOpT61h5Ex5agMl24VYsTFqIhWUHCifadd4eA9Y4a4U9kKnB/l1X52WchLp1P6Lj+kMLsPj3EEjVrOqiNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxvnvpjZPhhVBNtGr1GNShQu0aFDZEogNefdS+WoaRg=;
 b=V38Jrei2oZ3nZEiFqOAdirCRyEkfddggNRjCpwhvl0/TsolVpBZ1a5IRlx7Z0eCpb1IAdtPr2d1NbBGBdzR1xasJE3QhugwdZMUNMcQoG9mlwjpSCE8y8/M2MKX5KRV+WVxRChtSS75a4zpwtPgHb0q5Ml3GhL6nCyxohBNYtPiKxpX9WhQ5MlwI7ovyhdGIEX6Kud3pCYUN/2TdcmDdlnlGNl75/1ekl4r6FKEnrm6S9v3F5tvNJGQnTBvO99jwJqvN52mtcSZBKTR6D6QQsHNzKApXZE2VRGEQhq++/aTlDaSPQZ8hpuVqOmDGu+fz65kQOY2egmvVKawRbj0/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 17:26:41 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 17:26:40 +0000
Message-ID: <e2164d2e-10dc-4990-9c1b-70667a594fd1@nvidia.com>
Date: Mon, 27 Jan 2025 19:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in
 (un)?register_netdevice_notifier_dev_net().
From: Yael Chemla <ychemla@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com>
 <20250116025435.85541-1-kuniyu@amazon.com>
 <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
Content-Language: en-US
In-Reply-To: <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37d05a-85eb-48ac-d3ef-08dd3ef7c2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVFSbmlTdDMvdUx0TFdyWS9xZ25jbHVaYXlEVUtjdmdjNW0rVzQ5WUNKNWNV?=
 =?utf-8?B?ZUpYbGZEbThWQk1LdmdpL1pxOENNZExCWVh4OStScC9UZWtsVS8vWnh2STdi?=
 =?utf-8?B?enIzTHNMUnZvQTMxN3hBVEp0SnFvR0p4Tlh2dDFHRTdMSVVZNWd4U0U1VE83?=
 =?utf-8?B?WDBNdGtockk2WVJidlFNdUdOSmVkMks1NHc2YWxqK0Y1Zm9qYWVGQmVYYlV4?=
 =?utf-8?B?T3o2bThWSHBkc0F6L09wQk95Z0ZzdjlORXJvbyt3L2VsUG1ZM0k2VnY3dWtz?=
 =?utf-8?B?dzRVeGp0QkVWMHZpZEYyVjJmRW8xdU1ZNmdGODdMeC9nWitGWElLRDEvTWNQ?=
 =?utf-8?B?S3hzaTBTVUVzM2hDVDliR0F2LzlMU3FKNzduM3R4YjBKbUplWkZPdC80Vm1q?=
 =?utf-8?B?SjFIdGJSemRHWjhoWWZqNDV4ZXVqL3d3TmpZZmJ3VnJOQnZTa00xQXBJeDNz?=
 =?utf-8?B?c0I4WVZqdFM0eTVwWEF1Qm5ad2VaVzhtbmJEMDJtc0hvSzI2clZyMUwzeXZG?=
 =?utf-8?B?N0JyYUZlb05STzlTaGl5WExkd1ozWm9rR05iY2g3NzJ2bHR2Y0dxMWZYSXJ5?=
 =?utf-8?B?NjMrOENUZUVrUDBxeC9WTjFFdXNySDJJREZoS0w5RG12Q3NwQzVGVFhycW9Z?=
 =?utf-8?B?QW1xVmZPWTFNczZlUHZ0Tk02cFZnRTROeE1mSndnbC9OWFRZL3hsVlVqTjJV?=
 =?utf-8?B?QTVXQ1BFcFVOQ2hoNEZzUHFHR0NEL0ZtWmd3QkhEY3lzVVlXS3RxYlloajBC?=
 =?utf-8?B?L1hTRHlCanpDdUtUbFpBZTRkSGkya0pFZlp1QXVpS2JkT1lseTh1WFFydUlK?=
 =?utf-8?B?cEJUb24zZzREMlhZUVFtcjJKQUMvZ3p1UkFlTVRrOHBWNTdJVlZzd3kwVGtu?=
 =?utf-8?B?aHlBOHE2c2N3a29XbWZLcUEyMk54b3I5SENMbTk3azJ3QWFVbldqbWdhTDlj?=
 =?utf-8?B?ZHVPNWQ0cFJ5bGQ0RXdDU2FUTEx1cG9ZZFc0VGxzSHM5TFBEcUJKSU1uaDBm?=
 =?utf-8?B?aVN0UnBST3VqUXBBNG90UjV0M2ZVSVd4NEZqVGpjNCt1Wlk1OXc4SVdlb29o?=
 =?utf-8?B?VVgrYkdpcXpVeW54eFNmTU93d2FBUWc4a240T2VDVjN5SUgzbStVek50QTUr?=
 =?utf-8?B?emNQWFRGTGtsdW9SSEJWUWFkVnFaQlNrWHAwODMxNjZqT2lwZGNxSUdDbElv?=
 =?utf-8?B?OGVYV3pVQ0YzK0MwR1IveDBwZERla1luZ0dMMDFqUTlNQVZ4b3lSbzFNekNk?=
 =?utf-8?B?NytWdis0VGtDVVY3cmd5cDNNaW45Mko3SnRlbStDc2M4NmRWTUdob3gxQ00y?=
 =?utf-8?B?NERXZ3FsVThnTUUvMllxdFlhWENsdTNPNDdtUzhDc2pidjFWZXlpRTEveU9x?=
 =?utf-8?B?WlF2ZUNvcGlaOXd5T2hFUjMvWDZ2Y0FKbXMxSkIvcmNqSUpMZzFsa2lYWGxF?=
 =?utf-8?B?a25ZQTFqRWI4Y3ZmMkJOTmc4NTAwVmZRcFRsR1Q2MEROUFQ1aHFFYWVNQzRW?=
 =?utf-8?B?OC9KZWJlV2laeUxKSWo2QVRsN2ZrYXJiQUpkSzljWHMyS0JSbmxNT2ZxVVpK?=
 =?utf-8?B?eVVPSGV2M29rT0lpamd0b1M3d3pOWktZdm04c1o3WThaK2c2SzZsREs5Q1Vx?=
 =?utf-8?B?NjhQZ0VlZURsQ2twNDcrbmVEcGJIVFdLVUYwMkFUUWJ3Wnl5ZkNEY3hyVi9W?=
 =?utf-8?B?NitIUDZqSzQ1bUZYaEdsMmpvL3ZySTkzNVp1NUdrQ1E1TEYvMGxhRlY3cXNN?=
 =?utf-8?B?RjVacGlMU25ncUIrTlNYU2hEUStXTFF5WmhaaFlGeFJvZkZNNVFzRXRWUDVk?=
 =?utf-8?B?aDY3TmNuNHUweWc1SXdBNkZPbUU1NEsrMU5OTElFb0dxbDJNeXg1UExkT0Jm?=
 =?utf-8?Q?AeEJkFqyy8hee?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZXYnBMWWJFZUExQlViMFhpdVluOXFVbmYwQXlxQTZ4ckJNTGdMU0FGcEMy?=
 =?utf-8?B?anZoaEd4Q3FjNFdhVVIzd3RIR0lrbHRWUy9qeXR4ZzFGQ2htVlZhTWloZEND?=
 =?utf-8?B?bGhmaElrZEk4eGdLbkVWT1N2TEcwSWRnNEMwVnFjUW9YR2o2a04zSjlDanZ1?=
 =?utf-8?B?ZmFHM0s0NFN1NmltSjdFelo3S0lFNlg2NFIwSFRvbTRTd3BiL0crTGpXeFhR?=
 =?utf-8?B?MlFkbzNna01SSGhTVWttN0VsbmYvRUg5VlpOVGZzdnowS1kvSEtVRE94c0lQ?=
 =?utf-8?B?blc1UmZmRTBQSk5KLysxdkR3MURUcnA0U2hvRmhiRmZXbHZHN2JSOVRZdCtP?=
 =?utf-8?B?L0YzVExFaFhUbnIxK2lHaUh0dVI2cDlCWGxJL2pCN0VoS3JiSHJsNDlhUUhz?=
 =?utf-8?B?MTFkK1BCdXNxL0pxb0EvOHV3aUp3c0x2enk3cXBEb29OVlM5aDU3MWh5R254?=
 =?utf-8?B?Slp5SUI5QWVYb3F6dktZdlNnMXhNTkFXek93bm5PNDRpRlUrR2RVMlNxYlJF?=
 =?utf-8?B?T2tVU09sL2RoSnNBV1ZnRWtSeEZURzF3ekRnajNvN1RKMnlOakxXYnZvRUtM?=
 =?utf-8?B?NzNacUhESkVHNkcvckRjTzBPaEYram0xTVdya0xNeHBoOC9MTjZFWElzWUx0?=
 =?utf-8?B?S2JsVEpkR09EMUF6KzQwUkU4S2VrdVJnS1VHQ3lnOE90VVI0UnlFZlR4Y0lU?=
 =?utf-8?B?cUkvMW1aV0hZT0svUVEyY3NJbERkMlF6OEZER0VVZ1J6YXoySGZIdXR5aUpn?=
 =?utf-8?B?QW1lc1VZWDVmczFHa3lxUU16WEF6NHBGVjFpNVlTZTE5MDhGV0YxYW9RM1Bs?=
 =?utf-8?B?RkpXb01rdmZkajdUWEVOdEIyanNlamc3dWxpZ3dRdDVQSFhnbTRTdEs0dDBm?=
 =?utf-8?B?bEpRckFMLzFCUzB2TGFDMXlFUStZUVVWMzNzVHBYYndPVi9nektVVXFhemZT?=
 =?utf-8?B?d2Qya0VwZmR1MzVaNTVSbG9ZSkV3U3hVd0xFQUF4SDV3dTdEOFg1elZrUHht?=
 =?utf-8?B?SmY1ZExwaGl2ZGZ4UTdCSVQxR0lRK2wvenBMTXE2NFZnTzBFVjdxbHBBVW5M?=
 =?utf-8?B?NnpGMXlrRXBWc2p2dG56MUw5ZWZGQ1htdkdERUZlU2l0eHhxZkVCZDlzRVps?=
 =?utf-8?B?TkFhS011SFE5am55L01nMlk5Y3poWXVRQVBzTGw1TzV3YVcxaGQxRnZGVTNE?=
 =?utf-8?B?WVc4Y0hjOE0wemowT3VyQkJiQ0t6TW9Yam05TnNXS09BRjFWdmxEeGdYRzVV?=
 =?utf-8?B?T21VNUdCanI3RmRwRktKNVhTVHZFdVZmUFk3dU5TUEg0MllUVms3eHQxYVUy?=
 =?utf-8?B?ZC9RbEVFaXNaRmhWeklaaHVUd01hR3g1VjdQbnMyK0NaQ2FCT293WXUvMERH?=
 =?utf-8?B?NWdrdVEyU0N3c1E5NGVwR0QweWVJWnNJQ1NSWlhUQ1ptM09SYUNYWW5JOWpK?=
 =?utf-8?B?a1pFa1NucXg2WHIxMFNoSFgrUjIrOXRiZ1FCT1JPL21qWDFLd0RKbWhMMmFY?=
 =?utf-8?B?Z0ZxMVYrWGE1ZkdvNUZkMFR5N1NDZnBpVlFjcUNwY1F1ZnNpSVNmaElEamFF?=
 =?utf-8?B?N0ppbW40NXoxNXpTV3FGWXNta0VGWCtxY1l1MTJ3VCs1SkVTcVIrNmVqREND?=
 =?utf-8?B?L2doWGxsWThoOTJOQyt1OVpVWTJFR2hpc0Uyb3Q5Z2huTlFiNDNPTXhZSzRh?=
 =?utf-8?B?UXZnVXU5NlZnQ3VrNElMWTFyUE5oeG9KU00rVFVhN1NESE5mUnNDU2lndzFY?=
 =?utf-8?B?RG1vYkFJOWhCa1B6a2MvME9rL3dobVZBdFBQR0VmT2diSjRJOW5qZEhoeDE1?=
 =?utf-8?B?NVN4QXl0VHo4RWpOZHpOcmx5aHFoeTVaK2ZUQzFiV2tQUHY0aVdETUZQTnpx?=
 =?utf-8?B?b25PaWJ0ZzYvaXhOUERySVRPajRUTytDOGVvcmNZK2tGWXdlS3NNdkllRVNL?=
 =?utf-8?B?SllsM214cGpOUG9mQWJ0UTdhbHN2c2ZuRlcrTUhUWUJveDNQRFVXTWZRRmpZ?=
 =?utf-8?B?cWtnWVZMM0x5ais4SDhsUkhSQjUrZ2kzV0N6N3FEeXN0QkNKUUIxajZVQ2E4?=
 =?utf-8?B?dFJVZ0U4dWUveTZneWdPRURxSkRiaWRtd2tldHVudWVxeWFuYjhXOUt6SnV6?=
 =?utf-8?Q?yHPQ0FBc4o7hUyZmlQIdD6hmw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37d05a-85eb-48ac-d3ef-08dd3ef7c2dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 17:26:40.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz7CJKxVQfLMU0tXgBNx7fJtmLaforqR/lfHy3zQ4QNIbDzKCERN97DgEm4vIW1Uoz9u0tOG/zFJBPVVeCLzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

Hi Kuniyuki,

any update on this?
do you need further info?

Thanks,
Yael

On 20/01/2025 20:55, Yael Chemla wrote:
> On 16/01/2025 4:54, Kuniyuki Iwashima wrote:
>> Thanks for the report!
>>
>> From: Yael Chemla <ychemla@nvidia.com>
>> Date: Thu, 16 Jan 2025 00:16:27 +0200
>>> we observed in our regression tests the following issue:
>>>
>>> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x22c/0x280
>>> kasan_report+0xbd/0xf0
>>> RIP: 0033:0x7f70839018b7
>>> kasan_save_stack+0x1c/0x40
>>> kasan_save_track+0x10/0x30
>>> __kasan_kmalloc+0x83/0x90
>>> kasan_save_stack+0x1c/0x40
>>> kasan_save_track+0x10/0x30
>>> kasan_save_free_info+0x37/0x50
>>> __kasan_slab_free+0x33/0x40
>>> page dumped because: kasan: bad access detected
>>> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x222/0x280
>>> kasan_report+0xbd/0xf0
>>> RIP: 0033:0x7f70839018b7
>>> kasan_save_stack+0x1c/0x40
>>> kasan_save_track+0x10/0x30
>>> __kasan_kmalloc+0x83/0x90
>>> kasan_save_stack+0x1c/0x40
>>> kasan_save_track+0x10/0x30
>>> kasan_save_free_info+0x37/0x50
>>> __kasan_slab_free+0x33/0x40
>>> page dumped because: kasan: bad access detected
>>>
>>> and there are many more of that kind.
>>
>> Do you have any other stack traces with more callers info ?
>> Also can you decode the trace with ./scripts/decode_stacktrace.sh ?
>>
> BUG: KASAN: slab-use-after-free in notifier_call_chain (/usr/work/linux/ 
> kernel/notifier.c:75 (discriminator 2))
> Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
> 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0- 
> gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
> dump_stack_lvl (/usr/work/linux/lib/dump_stack.c:123)
> print_report (/usr/work/linux/mm/kasan/report.c:379 /usr/work/linux/mm/ 
> kasan/report.c:489)
> ? __virt_addr_valid (/usr/work/linux/./arch/x86/include/asm/preempt.h:84 
> (discriminator 13) /usr/work/linux/./include/linux/rcupdate.h:964 
> (discriminator 13) /usr/work/linux/./include/linux/mmzone.h:2058 
> (discriminator 13) /usr/work/linux/arch/x86/mm/physaddr.c:65 
> (discriminator 13))
> kasan_report (/usr/work/linux/mm/kasan/report.c:604)
> ? notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 
> (discriminator 2))
> ? notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 
> (discriminator 2))
> notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 (discriminator 
> 2))
> call_netdevice_notifiers_info (/usr/work/linux/net/core/dev.c:2011)
> unregister_netdevice_many_notify (/usr/work/linux/net/core/dev.c:11551)
> ? mark_held_locks (/usr/work/linux/kernel/locking/lockdep.c:4321 
> (discriminator 1))
> ? __mutex_lock (/usr/work/linux/kernel/locking/mutex.c:689 
> (discriminator 2) /usr/work/linux/kernel/locking/mutex.c:735 
> (discriminator 2))
> ? lockdep_hardirqs_on_prepare (/usr/work/linux/kernel/locking/ 
> lockdep.c:4347 /usr/work/linux/kernel/locking/lockdep.c:4406)
> ? dev_ingress_queue_create (/usr/work/linux/net/core/dev.c:11492)
> ? __mutex_lock (/usr/work/linux/kernel/locking/mutex.c:689 
> (discriminator 2) /usr/work/linux/kernel/locking/mutex.c:735 
> (discriminator 2))
> ? __mutex_lock (/usr/work/linux/./arch/x86/include/asm/preempt.h:84 
> (discriminator 13) /usr/work/linux/kernel/locking/mutex.c:715 
> (discriminator 13) /usr/work/linux/kernel/locking/mutex.c:735 
> (discriminator 13))
> ? unregister_netdev (/usr/work/linux/./include/linux/netdevice.h:3236 / 
> usr/work/linux/net/core/dev.c:11633)
> ? mutex_lock_io_nested (/usr/work/linux/kernel/locking/mutex.c:734)
> ? __mutex_unlock_slowpath (/usr/work/linux/./arch/x86/include/asm/ 
> atomic64_64.h:101 /usr/work/linux/./include/linux/atomic/atomic-arch- 
> fallback.h:4329 /usr/work/linux/./include/linux/atomic/atomic- 
> long.h:1506 /usr/work/linux/./include/linux/atomic/atomic- 
> instrumented.h:4481 /usr/work/linux/kernel/locking/mutex.c:913)
> unregister_netdevice_queue (/usr/work/linux/net/core/dev.c:11487)
> ? unregister_netdevice_many (/usr/work/linux/net/core/dev.c:11476)
> unregister_netdev (/usr/work/linux/net/core/dev.c:11635)
> mlx5e_remove (/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> en_main.c:6552 /usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> en_main.c:6579) mlx5_core
> auxiliary_bus_remove (/usr/work/linux/drivers/base/auxiliary.c:230)
> device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275 / 
> usr/work/linux/drivers/base/dd.c:1296)
> ? kobject_put (/usr/work/linux/./arch/x86/include/asm/atomic.h:93 
> (discriminator 4) /usr/work/linux/./include/linux/atomic/atomic-arch- 
> fallback.h:949 (discriminator 4) /usr/work/linux/./include/linux/atomic/ 
> atomic-instrumented.h:401 (discriminator 4) /usr/work/linux/./include/ 
> linux/refcount.h:264 (discriminator 4) /usr/work/linux/./include/linux/ 
> refcount.h:307 (discriminator 4) /usr/work/linux/./include/linux/ 
> refcount.h:325 (discriminator 4) /usr/work/linux/./include/linux/ 
> kref.h:64 (discriminator 4) /usr/work/linux/lib/kobject.c:737 
> (discriminator 4))
> bus_remove_device (/usr/work/linux/./include/linux/kobject.h:193 /usr/ 
> work/linux/drivers/base/base.h:73 /usr/work/linux/drivers/base/bus.c:583)
> device_del (/usr/work/linux/drivers/base/power/power.h:142 /usr/work/ 
> linux/drivers/base/core.c:3855)
> ? mlx5_core_is_eth_enabled (/usr/work/linux/drivers/net/ethernet/ 
> mellanox/mlx5/core/devlink.h:65) mlx5_core
> ? __device_link_del (/usr/work/linux/drivers/base/core.c:3809)
> ? is_ib_enabled (/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/ 
> core/devlink.h:58) mlx5_core
> mlx5_rescan_drivers_locked (/usr/work/linux/./include/linux/ 
> auxiliary_bus.h:241 /usr/work/linux/drivers/net/ethernet/mellanox/mlx5/ 
> core/dev.c:333 /usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> dev.c:535 /usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> dev.c:549) mlx5_core
> mlx5_unregister_device (/usr/work/linux/drivers/net/ethernet/mellanox/ 
> mlx5/core/dev.c:468) mlx5_core
> mlx5_uninit_one (/usr/work/linux/./include/linux/instrumented.h:68 /usr/ 
> work/linux/./include/asm-generic/bitops/instrumented-non-atomic.h:141 / 
> usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) 
> mlx5_core
> remove_one (/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> main.c:965 /usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/ 
> main.c:2019) mlx5_core
> pci_device_remove (/usr/work/linux/./include/linux/pm_runtime.h:129 / 
> usr/work/linux/drivers/pci/pci-driver.c:475)
> device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275 / 
> usr/work/linux/drivers/base/dd.c:1296)
> unbind_store (/usr/work/linux/drivers/base/bus.c:245)
> kernfs_fop_write_iter (/usr/work/linux/fs/kernfs/file.c:338)
> vfs_write (/usr/work/linux/fs/read_write.c:587 (discriminator 1) /usr/ 
> work/linux/fs/read_write.c:679 (discriminator 1))
> ? do_user_addr_fault (/usr/work/linux/./include/linux/rcupdate.h:337 / 
> usr/work/linux/./include/linux/rcupdate.h:849 /usr/work/linux/./include/ 
> linux/mm.h:740 /usr/work/linux/arch/x86/mm/fault.c:1340)
> ? kernel_write (/usr/work/linux/fs/read_write.c:660)
> ? lock_downgrade (/usr/work/linux/kernel/locking/lockdep.c:5857)
> ksys_write (/usr/work/linux/fs/read_write.c:732)
> ? __x64_sys_read (/usr/work/linux/fs/read_write.c:721)
> ? do_user_addr_fault (/usr/work/linux/./arch/x86/include/asm/ 
> preempt.h:84 (discriminator 13) /usr/work/linux/./include/linux/ 
> rcupdate.h:98 (discriminator 13) /usr/work/linux/./include/linux/ 
> rcupdate.h:882 (discriminator 13) /usr/work/linux/./include/linux/ 
> mm.h:742 (discriminator 13) /usr/work/linux/arch/x86/mm/fault.c:1340 
> (discriminator 13))
> do_syscall_64 (/usr/work/linux/arch/x86/entry/common.c:52 (discriminator 
> 1) /usr/work/linux/arch/x86/entry/common.c:83 (discriminator 1))
> entry_SYSCALL_64_after_hwframe (/usr/work/linux/arch/x86/entry/ 
> entry_64.S:130)
> RIP: 0033:0x7f6a4d5018b7
> 
>>>
>>> it happens after applying commit 7fb1073300a2 ("net: Hold
>>> rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net()")
>>>
>>> test scenario includes configuration and traffic over two namespaces
>>> associated with two different VFs.
>>
>> Could you elaborate more about the test scenario, especially
>> how each device/netns is dismantled after the test case ?
>>
> 
> we set up a network configuration which includes two VFs isolated using 
> two namespaces (there’s also bridge in this topology), we pass some 
> traffic between VFs. At the end of test (cleanup) we delete network 
> namespaces, wait for 0.5 sec and unbind VFs of NIC.
> 
> note that when I extended the timeout after deleting the namespaces the 
> issue doesn’t reproduce.
> 
>> I guess the VF is moved to init_net ?
>>
> 
> this should be the behavior in case deletion of the namespaces happens 
> before the unbind of VFs.
> 
>>>
>>>
>>> On 04/01/2025 8:37, Kuniyuki Iwashima wrote:
>>>> (un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
>>>> the notifier for all netdev in the netns.
>>>>
>>>> Let's convert the RTNL to rtnl_net_lock().
>>>>
>>>> Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
>>>> yet) protected by per-netns RTNL of both src and dst netns; we need to
>>>> convert wireless and hyperv drivers that call 
>>>> dev_change_net_namespace().
>>>>
>>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>> ---
>>>>    net/core/dev.c | 16 ++++++++++------
>>>>    1 file changed, 10 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index f6c6559e2548..a0dd34463901 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -1943,15 +1943,17 @@ int 
>>>> register_netdevice_notifier_dev_net(struct net_device *dev,
>>>>                        struct notifier_block *nb,
>>>>                        struct netdev_net_notifier *nn)
>>>>    {
>>>> +    struct net *net = dev_net(dev);
>>>
>>> it seems to happen since the net pointer is acquired here without a 
>>> lock.
>>> Note that KASAN issue is not triggered when executing with rtnl_lock()
>>> taken before this line. and our kernel .config expands
>>> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not 
>>> set).
>>
>> It sounds like the device was being moved to another netns while
>> unregister_netdevice_notifier_dev_net() was called.
>>
>> Could you check if dev_net() is changed before/after rtnl_lock() in
>>
>>    * register_netdevice_notifier_dev_net()
>>    * unregister_netdevice_notifier_dev_net()
>>
>> ?
> 
> When checking dev_net before and after taking the lock the issue won’t 
> reproduce.
> note that when issue reproduce we arrive to 
> unregister_netdevice_notifier_dev_net with an invalid net pointer 
> (verified it with prints of its value, and it's not the same consistent 
> value as is throughout rest of the test).
> we suspect the issue related to the async ns deletion.
> 
> 
> 
> 


