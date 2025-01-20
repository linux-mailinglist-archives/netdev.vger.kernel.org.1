Return-Path: <netdev+bounces-159807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B0A16FC0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D027B16418B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C519BA6;
	Mon, 20 Jan 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPXSKGSc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0B10F9;
	Mon, 20 Jan 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388833; cv=fail; b=Jy8EHUU2y00AVszWpkXvO0UeztC+qhihO2GZfP+jbX4udU+JCoQVFj3vP9JbU35WlflFj3/RfqsYqz7pd9KovcNpWwpYzsWLK8oYxUtSK+wTKThMzByy2SLd4DSj9m1AtsgWJv7Z5BGlcqUzSR+wH314Xrd7sDLp5HRJ/Yo7CZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388833; c=relaxed/simple;
	bh=SNpATW5DCGzZM/MlOW7Zavj8CwmSQkaqDIJfMRBlrk4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qTakDHpUQdYuhTt3SE57EdErgowSnd1NZAcrwNOzmU7Ndq4K9DKUQCZc27au06Ha/nRe3RWOZD5lmCpf5N1/48tYE7BCvB4BDk8XCnbvs5cBqjc9zcL/1tYjbI7sdxSsGcD4qxkUlzQcxsPBx+OpAOQOiO49LY8Tda4gjGZl/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPXSKGSc; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXN3ClnryUU50zz3DAKJu2qs9cxCUW8e8BNCE7o3muUheDAil9zDRubg6OnIFR53E0ck734fVYI9l7LfFtd6CHFPRipDJyFYeTfZGRk3c9vX59eMZo3tFs28vp/oKkCD2R6aUF9e54nDxVI+h8rcfBE1/hlPFVRdAaF3GdrrPSiM9tjBIpGg6cXC3KtE+ZoUhZYN726bwy/BGsG74Cx5CxOMrYDBH9kqXM93o6FOFbD+P2U17n4r2ca6xkix4pv/TzY1G9/kzsBW9gUcu9cUMAFwKmwdwGkBIIHkjmAxZ3aT8L8p1K5RDCmghThhNA5gyo+FZJkUqIZP4CeEh4jpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk9GoFCgCA5B/StXPTmb7jxvVkZiLXQLd5bPcnTUYxA=;
 b=PX/op4+JGZ6l3YTuXJHb7jKB65fetaoKdZJRVHiiLmvNUC8Q3NsRToFBa7BJ+5uhVPA5DLeFexcTSGz7HFB27m4UVVSjQetBWa4Pxd2ohxrpp2ap+FucxJLgFVfP8t9MHcyIz0FB8Tn5a8kDZa9UYccHjsFmWZODvIEpLNcotTpQ7mVrjeWCQpE1qMGycdnPgYnLqdpFasxvRTpTbOx3F2NHn8omNK69dxWVNknA+byGh+p/ZYduFrJAz0onffLH32AfIAyWZMBM50OumTPaQlqYCTxY3IHrQrIpahQ+cuBKV9aVy+EhmS4ft+xl16w+2HzLUDQDyruC9WAeN+UCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk9GoFCgCA5B/StXPTmb7jxvVkZiLXQLd5bPcnTUYxA=;
 b=pPXSKGSc00R1m197TW6yGB4MWzUdG5M2P8Dtl2qg2/0Ymsab1Dt1wj9TFxy0MBNHqSU6kppw2cE1sgWbrCZ6hUVcv91GSRbMNRmGak0cxsj6J5ZKEq7/X3EWHCn11T09QsUy6CeoHy2MrLbWUHBX1C4UEeACxjIzhToi/cA0gwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 16:00:25 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:00:24 +0000
Message-ID: <212cb2c1-5439-b039-a787-5f5aaca8b883@amd.com>
Date: Mon, 20 Jan 2025 16:00:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 09/27] sfc: request cxl ram resource
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-10-alejandro.lucero-palau@amd.com>
 <678b0adea8dfe_20fa294c@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b0adea8dfe_20fa294c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92b490-f77d-4246-786b-08dd396b8ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFZRzB0MkdhenhTMkZmZ0tTaVJLQ1lNQWEzK041WTFENWFiSUdBdWpDazB0?=
 =?utf-8?B?NGFOMHhDeHphRDQ0Z0MzdEpxY1VmZ1IzcFpqOVgrSE1WNWFFOEtSWnFmb3V0?=
 =?utf-8?B?eEpSWTNWSFErWmQ1ZkoybHZhY2VEN0ZDNUd5dktReGJpZnUrSCs1c0sweVJh?=
 =?utf-8?B?QU43UmdReVdlTlRRakhsdUhJS3hib0VDcW1ITTB3MDVpMitJQXRycmN3b2tJ?=
 =?utf-8?B?U2s1bklid0NxNmFiOE5NK0IzRzhuOEVvSWVmcVRCVjRVMHNiTk05WStwemw5?=
 =?utf-8?B?UHozcVh3VHRhcVB5U1pIVlIzaEd0TnBHN2VPL0JyZDlNdTE2ZjcvRU9zR05o?=
 =?utf-8?B?d0tZNEZVc2V5azJReDJNWFZtNENocjdHbEZrU3B2ZVJjMFBEU0ZmRDR1enVJ?=
 =?utf-8?B?czVlL2pvSlRHc2hHMUNWK0lhdVI4RVNEcEQ4R2I0dGZBT1hwVTExNTlYSzhV?=
 =?utf-8?B?bk5YZ2JxZmZ6NHY1dVpoRTBEYU9VSDNXQnVNejhjTlp2bGFpVWRHNEtNOHFi?=
 =?utf-8?B?TERONTZXZHVHcVRqTSszSC8yT0REcDYrbFVsTUxzUVNaeHY5NmNaRklHRzJu?=
 =?utf-8?B?LzVEU0VzMjRKbDJSUDltekJudjNKZHRsYmRBdFBNOUt4UXZ2WnVtM1RZdGxv?=
 =?utf-8?B?b21IYTNuOUZqVXlOcnQ4V0FNK3lyejR0UExwTGpreGJwQkhjUlhacFQrMmpw?=
 =?utf-8?B?bkZGMTRPbGhaY1dRaFErSTBDQ2FtZnNHM3dsdHRLYU9kUjV2Q3ZVaVhuVTZE?=
 =?utf-8?B?VHRrcTR5eDhUN0NvVVVPS0ErdzJQS1NicWVyZ3Arc0Z0eUUzZzVtaWtJOVZy?=
 =?utf-8?B?NzJzMmNQQmI0TlRXcThySExYNGptL0FGdGFuK2lUaHVvZHRsbmRmYkR1ajl4?=
 =?utf-8?B?T1ZWUktnemZXQkNqSVZaZ0dmQzZKbk8wUnF0QjNRdGxmMVoxZnhUSk4yUUhT?=
 =?utf-8?B?dENGOUtiajhWRktqenBwWGptN1hTUU9obzUyTEdVRVZET2svQUpFeUdOanpZ?=
 =?utf-8?B?MUllWUZudHV2cjlleVp6VE1uVFROWVZIcDVDRVhlTmVVbktlOHM2c2dHTDV0?=
 =?utf-8?B?UTllRUdhNTFJMHNiVzJHRURlbDVtSUxSYk1qeG0vT3FSVWx1S2t0Yzh2WjZv?=
 =?utf-8?B?R3d0UFNPcFhFN09pVDR1Zk9XaDEwVjdZRDVVWFcxaXI1ckNuSXZ5Vm01ZWwr?=
 =?utf-8?B?ZVNoc0Z2dHNESmdEc243bEpMNUh5YXptZnUxaERtU0JzUzB1ZEZGZlBwSjJY?=
 =?utf-8?B?YWRkMUpPcEU1T3pqZ2hVcDc5U3krV3ZneERoRk1IRlRCUVBISW56UnBsTE5K?=
 =?utf-8?B?dURyb25zQ2gyWEZqTzBFMnhOYWQ3aHpWWUFOSzA2UXYvNFM5TEJJZlFUNnA3?=
 =?utf-8?B?RDVPWEVoY3Q4QktSNmFLc0JJMWJrdmhwWHdNYWsySkhYbG1zT2cxb0FJZGYx?=
 =?utf-8?B?TVkrSXJiN3daYm81WFZOaXhMLytrZ2k2Q2dUMXk3ek5OYWhhUGZPdnM2NFAv?=
 =?utf-8?B?UVRXcEZWWmFVNVd2Qm1aM1lURWZxRlRJbTB0MmpUWlhPV0ZwY0xJRUllN0Vu?=
 =?utf-8?B?QW5UdTFqdHBub2ljNUowODdCVHlKVHY2Skd5bXVvUUg5QTJ1MFZuKyszTkhN?=
 =?utf-8?B?N3JSNTE4OUN4K3ZTQVhEcUYrSitxK01Bdmx6OGJSeURoUXh0ckQ4V0xySHpu?=
 =?utf-8?B?NHRJZ0tkN21Kd0hJVllnNjRPNDY5K2pZbjFFVXlHR0lZdkUrZ3ZwVFFpcCt0?=
 =?utf-8?Q?TP0RwV01JXJ2hjYwtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRvYzdWUTZ2Um5mcjVMUmZ1ZW11R3Jsdy80MjVRNkszdC9lRnRvdHlFNGVE?=
 =?utf-8?B?R3BLbFRSc2FiTXhyMTZvWmlkVE5Bd1AxUk1ma09IaW9jUXYxekttTDJ3eE8v?=
 =?utf-8?B?RTdtMCtESEphalFxU1hHQXJNNkJUSjA3a2JTRGxUT0RSVHBDdndZZnByZStU?=
 =?utf-8?B?b08vOUxFbG1STDlwNExQZ0QyVWdPVjhWak1LY2p4Rk53WDhueW1SQ2tuRGRG?=
 =?utf-8?B?VEU0WStOeWlIUEs1UEtwSWk4bzk0RWhZeGFkOXBEU2VVcmU5TVh6a3VwaFRQ?=
 =?utf-8?B?a3dqUmtMNGUxOEFDZk5uTVBnYVg1NVNLSTZzUjZlY1RWTGZsbW9QZGQ5NWtq?=
 =?utf-8?B?TTJMMWdyVWZWbHpQalZDSE5KdmtUdFVscGZBdjBXemU0RGhhamkrcDVnQkhH?=
 =?utf-8?B?V3RpN09odlVBVmd1NkdEZjNrKzh3V1BjMUdibzhuVUVEQmE4SCs0QSs1bWJj?=
 =?utf-8?B?ZWpwU0kyN2RIYnZpYWFQZTc3d25JOUhhaDZVa3B5VUlWRFY0ZEc1aVNsQ0FC?=
 =?utf-8?B?ZG5UcVk4aVM4RWJ0aXBTUk1GQnQxRXpGRm5wTUg1eldjQ0pDTGxGZmp3Wmow?=
 =?utf-8?B?cndRNytOZG1Hc0k5RFJTNDJiQ0pSVnVFT0tIZFV1ZDNSZ2hZWm1yK3NBMDJY?=
 =?utf-8?B?Y3ZmT1RtdlEwYmJNeVZvaXYvQkMxWk13cWgzdWVXM05GT1hJYXROVDU5d3Vj?=
 =?utf-8?B?SEZGVDJiMlhGeVhhUGpCU3l1dk9nSzlNWEtZOGRTV0I4ZHlzOEhQS3ZuS28x?=
 =?utf-8?B?U0hxN3A1WnFyK08rUm5oZW5GS2d4YXdRSk51emJOaVV0MWhJekUrVm1MZ3Az?=
 =?utf-8?B?dG82T2ZuQUhzUmpWcXFJb0VqYTQ0WG9hbGJXUS9Ncy9vSktEU01FY1dIVjQr?=
 =?utf-8?B?U0czdjdhWkNCYWl5MVFXUVFvak45cEpNSDY1ckp3S0U5cWpqckVLTFd2ZFJj?=
 =?utf-8?B?Q2UrcTlqaW9IMFBnRUN1KzFyc1ovS25ycFZnV0NPZFFrQTZDdHdzNExTUXNZ?=
 =?utf-8?B?dExlelBLK3lJVTlaZFRMa0c2U0VWdVg5L0J6SmN6NnN6TC9aLzlacTUyRzRB?=
 =?utf-8?B?clJmMWxhQmFuT3Z6KzQzMG9YUWM3NWs3UTFMSEZXaDM4TDJpdTVDTmJNL0NM?=
 =?utf-8?B?QUMvZUkwVnVkdURRdW9aaFJWTkVSK0lLcDVGTnpKYjZha1V6WFB4L3NRRlBa?=
 =?utf-8?B?M0tIZGVlTS94bEQ2bUZGY2s3UWpCQWZpTEVEaHcwdXp1ajdhZVB0NDV1Y2lp?=
 =?utf-8?B?bFBoSDVFR3lWejRsUVlqam80bHhjN2xqazZaQTFDSHlPbkplMWlpWUp2bXRL?=
 =?utf-8?B?UXpJcHRxWDJBdWVDeUJqV2d2YXVPRVg3RkE1M2VKQXE0SG1KY2hNRnRxMlBY?=
 =?utf-8?B?RGFXUXltOWQ0cGwyR2tCT05aU21TbnNsZis3eXlDTmRabENORC95UGQwTVpi?=
 =?utf-8?B?QUNlRVVVa28rNmxPRGpUU2lrRkNlb01hSUdhZ2N4TG1ITVE2UjNESHRWR09v?=
 =?utf-8?B?T2RPWmNzaDFTTFdNbzdleHJFS0xPbUkwZzkvTmt1Y1I0MzRPcFpvOXBtSS9K?=
 =?utf-8?B?amVqK1B6Y1JrMTJncUtCanYvQXBZUmxleG9xaU5nd0xTbjZEeGFYejd3WU9C?=
 =?utf-8?B?M0JGSEcxZGJ1SVVGaUtLNW5oY3ltbkVWN29tblpEenJmb2RRWkNreDU0cEQx?=
 =?utf-8?B?Y05SNmFPQVR1RlFwRlFOSk9MS3V3VlBuWkFiS2MwMVI1MGdndzZNSEd1VDhR?=
 =?utf-8?B?RzhBVStSRVJVMXRWVVVTZndlUUJwdm54dFUrUXoxNkFSM2JnalVUUkt0VHd6?=
 =?utf-8?B?d2hCWlh0ZzZtdXZJRFdzazFmZ00vQnVxdjdXT0F6UURacHg5bzlqOGxwQ1ZQ?=
 =?utf-8?B?N1R1aUE1V1lXWS9lakxxeEk3WXIwUlRXdTM1MS8vZzUyZ1B1M2NjOXFNMDBV?=
 =?utf-8?B?WUZRczFuaDJSeVkxVXc1NWtkck5VWG5rYU5rZEZ0Ly9Nbk9URlYyakd4a0F5?=
 =?utf-8?B?NklyOUFpM1dhcitYdGtrN2lHZDVUNDhIVHdRYTNtaDRqMUphSG8wOEZFaUdK?=
 =?utf-8?B?ZXE0QTdXdU9oMjVxTEowODBXWUlxQW4yeTljelIxT1dBYm9LaC9GMVNvQXB1?=
 =?utf-8?Q?sPOUUPWmOAU2qElMDjvK4M76M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92b490-f77d-4246-786b-08dd396b8ce4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:00:24.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P7k3a9oeeDJKfxKJ7YdmxZP5TywW7GyvO7Z3lsJaCxsGN9dxXX+g5Fk9q57W7nkngqCNY3u1nnNl2qRpchClQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457


On 1/18/25 01:58, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl accessor for obtaining the ram resource the device advertises.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 29368d010adc..2031f08ee689 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -85,6 +85,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_resource_set;
>>   	}
>>   
>> +	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL request resource failed");
>> +		goto err_resource_set;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
> Given that the DPA layout is a static property of 'struct cxl_dev_state'
> once set there is no need to release it. Notice how there is no release
> in the memdev case either. The 'release' is freeing @cxlds.
>
> Now, any DPA reservations from that partition need to be released, but
> those releases are with respect to cxl_dpa_{alloc,free}().


Yes, it is now all more clear after the "DPA layout mess" work-in-progress.

I'll drop the release_resource in patch 8.

Thanks



