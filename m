Return-Path: <netdev+bounces-179568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69AA7DAB2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE716CD52
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93A1547C0;
	Mon,  7 Apr 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3mH6aqwf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93ED218AC4;
	Mon,  7 Apr 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020302; cv=fail; b=ooU+Rc5L2mWGN0Y546xMcmUYKe8bkbSTS3OjXwAM+NwpZwAAinpbmNsPnx+j3T4Bx6VwM60Wqvuf/scy8YXkZAyeX0McLFdS71ZRNvx+4Q6GJxehuTnytGHvqUQ5iD2MsN9GIsyxNENaL9fafEQw7v0wvVjSgGyc1RZ9cg2nyp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020302; c=relaxed/simple;
	bh=bxj9Y12UEe2dq6z8CgDabmoF9QreTUPUsvrf8Epxpxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rCLUSkN0vD2TclKgnGdN9vVrDKLi9M5fFZWP+BSeJngChQ0zfUin6iKmMDGIyMxJTU6Mfeb3b1keSmoCKFNNJOAzII56CMBFlVeahfBuDzFvYx2ScFxBxIk4UWAwUiiedP9l7x61sv0w4o+d2udbLjRH6U2i8A9qkakam4KV3pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3mH6aqwf; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpp6GLha27HBjOOQMEhKBTroOD2ZVYuTcXa1PDSsgLcfEA2bx3gDB4oG37qPSw9Lt77rRqvWTmbOsn5J5XjY8mk9AR/4y/c+WFqCxoR1EOusFG4swVozaiGjM96i5ArozAMDsq9RcB9+9GtD0+lxfDlxcSzAUHDBWcuuvXoJQ90OvmcVTEAPeKWe8UpOnoAlJzI7dTB4EXC6cL8/xvEanQgTbrb6/Mosas9Er1NAmY9GmKUhs45yTrMSgBr8DOcc9UO5xh5xdNC4X0/yHfinVVzOFHBGLXmRxQczIDpgOeJnK1OaRz/cSsvZ3TBrXK9wjtpEvk2X+7/6kHZRYFjiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za1QWtvxanahxBNw2EKjrvjbucqwwjxlpAfuPLdtXRw=;
 b=a+T4am3z6XYN1C0ewgbVXq5j64H2x2B8cEacivNQvcGW82riDAl8ngOpT01vsWBu3HgwTij6TDq7Q0gPoxVU8NjGvmDqKflz+LQNzaMLqL2KaujUSCk2oKfttu7OBK7MDxdPseqmZbjzWplcOnvy0hsd39gZ6VD/oMSYiUfpzVyimqXMO5H67DfCsdCmZzzUhJFwKiKFcpbq4Z6SpxlcX0DzPlhnT1Z/sml63CMq629d2G7o0fxujSWLa4SRSB8FnE2GrDxOfsWboVwVaR6KnToYZUMelqbO+crHR2wC8bQF2iEoJxZrV09s7ZPKoujWfOCsboSGhD1bhoRrH+r+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za1QWtvxanahxBNw2EKjrvjbucqwwjxlpAfuPLdtXRw=;
 b=3mH6aqwfJ9H/jJ+VfJurwjCAxb9Bz0neTg1zzX/xZl2k0oQlejiJdofjXkc4d2oXJ76yZdS9SIjztvt5pNoT5dBH0ppSNy4AYszIfu4juimND65ah498w3SXEcjVIkdjkkExe3Q8PNhN1kqd2k/BWD57Ts5ayN5KeCtF6POt474=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 10:04:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 10:04:57 +0000
Message-ID: <320c4b16-2029-4792-9288-8ccf99bf07cd@amd.com>
Date: Mon, 7 Apr 2025 11:04:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
 <20250404170329.00000401@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404170329.00000401@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0206.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f97937c-ff8b-46e4-c5b5-08dd75bba67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDFwUzR6Rk1YNmJVQ0JjeSs0azF2WmNsejZNSFVTOCs3eCtZRy9FcVNOaGlJ?=
 =?utf-8?B?VW05KzhkNElzZldMK0hjYzk2dCt6WXlyYkJuMGJrY25OMWJpdU4zR0dhTVlo?=
 =?utf-8?B?QTgwRzFPVHpkbzFVMlZsUWhxT0VoK0ZMWmRsNXlCZTR0V0w1SFQyamZpY2pM?=
 =?utf-8?B?WU15MHZjOXFzZG9aUS84YTAwdEs5eWMzVHQ4Nk1DZXF6NzVnKzh1b3Q5Yjh4?=
 =?utf-8?B?RzdHWU12eFpQWitFMXNnQXRLeDJFNWgwdlkyTkt4UFlRazVBaSt0ZHZXTis5?=
 =?utf-8?B?QVRJRFFvZEplalM0eTlDcUZiQmNNakdEOWpLeVBCNHZGbXF2OFdWZ1owMzVu?=
 =?utf-8?B?ajI5N0tQN0tPT2daNXR5UVBVTHFhdXAxZFZkMmQvQW9PZjNwQlRDN0kzWFIv?=
 =?utf-8?B?dmpXTGdDZndqQ1lNbGpYNGdFbytYZ08yQTVTOGJlS0VEaFZTTkF5aDh5K2lO?=
 =?utf-8?B?U3ZacEd4SGF2ZnpaaGphdlVXY3QrQzZaWlJYR1kwTml0aHgrNnNNbWV6eXRB?=
 =?utf-8?B?SmN2M1BIdU9UbDhFdE50R2pZZWVIa0dFL09KaDZyUGdGdTc0K0R1WXFTbVBG?=
 =?utf-8?B?aXdLU2E0R0ZIMk1iWmYvN3U2RURXQ2VQRVIrc1B3V1JNTFI0MytNUXZOenoy?=
 =?utf-8?B?dzJ5RDRJbjYyK290M3VYOHpMSEdVSFc0TnFIMjhURFdnZmYrMzJLMDFtR1pm?=
 =?utf-8?B?d2diVmk4Uk41RW9TK1llS3VCU0xRZHdSQkZOaU1na3BCRXdBaUNyT2tpSm43?=
 =?utf-8?B?QzhvU1pPblVzZ3lhYTV6M3daS0IyQmJid0ROWnZlQUdnS29XWG1JNkdJczlv?=
 =?utf-8?B?WmRqYkNRY1lOZDJmMG5tNmw5cTJQT3NKSFBuOHc4WVROMVJJNElaQXhJU1l0?=
 =?utf-8?B?SkM2aDBRQ0FCczNrdEIyL2hKZnoxZjExeURsNUhCZFVaVHZuQk0yOFc4UnNG?=
 =?utf-8?B?cm4wb1dETWlBanp5RlFKaU8xMWtReVV5U1BQWWsyWnFsb1g1Z0xzWjFFZTRM?=
 =?utf-8?B?MGxyT3dBdjlEcjUvN25BazJPeTBIcmJCU3VYWngwcDNXS2xJSCtjNzcyV1RB?=
 =?utf-8?B?Y3VXYkRjejdsdHp6OGdFUnZQc0sreW1RRUl1b0RERzRPaUw0S3h3WGlFWkt3?=
 =?utf-8?B?SVlDU3hTNXJ3Uk9iNDhNak9zeEoxc1hiKzkxRDQxTndxZHJENTh4MmZiNWQ4?=
 =?utf-8?B?RG1xaWdJQm1XZjE5N0xBR3NiaWM2UFJGYnozcWcyYmczVW1FK3ZPZ0NkWGJj?=
 =?utf-8?B?bHNsUFFVVVhScFBDdXRMcEYrbmJaREFySml6MEU3bVFEelJEY2Y5bDVSVThU?=
 =?utf-8?B?enNQMnBQcHMwaFV0U0JEdGhyeXdKOUxTbUlSVEFBODNmSFcxdmxHVWE5Nlh0?=
 =?utf-8?B?b2t5VGhqQjNVZ2hoR3RrdU9zaGVtWVgxS3dsTkhSWHk3M2VvSUlWbzFKUUV1?=
 =?utf-8?B?aGY0ZExLcjN2NmZsY1N6MWwxWTVqZk5ubVVqMklSS1lDdEFOZUEvYlVIeTJK?=
 =?utf-8?B?S2hXWDFYTy9jSkVFRUhWdEcxWFNETUhQeENaWitpNS9TalNrdDBpVkUxaHZn?=
 =?utf-8?B?TTJlWko5SjNFS1cvZWxxZnFVaVp0alY3Z24zSGQ2dWMzN3kvZ05iSS85eWdH?=
 =?utf-8?B?NXdPeUpTdk9HSnZrZTFVSk5IT1pEMGlYb09JdFBDK0VIMFpjb2R1RnhuY2pk?=
 =?utf-8?B?WlNvLzYxTVJtVnFQb0xpakFsbG5OMEphYWJ1UjQ3U2Q0TG41QWhpTHhnMlVT?=
 =?utf-8?B?N2RkTmE5OFl4eks3SXZxS09SMjBjUkNGWHNtWUM3SXhXbFdBejAxNDVqWjNo?=
 =?utf-8?B?a0xoT3ZHZ01TL2JYN01IdUQreXQ5dDNoVzBEUmFJdVZuWDFhaFZKcnBBbUtR?=
 =?utf-8?Q?CKwtru4uknWqt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkN0eTV0WCs3Y3pMMUZGRGFPdWFncFF4Z2tyWEw5OGFVSDhYbzR5YjFLZE5s?=
 =?utf-8?B?R0VBTnU3VFozZWxvb09wZHpZVUZNdjA5YnZXTlJXZ0t1WjBEdmJ2dE9DZ2Fm?=
 =?utf-8?B?OGtGcjB0dG1sMm95YVNoWWxFTHloUFFBditLVVVxTUV0VmJXamZYQzNZSzB2?=
 =?utf-8?B?WE81UFhiZ3dUQytnZjl5TWFjbXFnQzVyMUNIakFOUHBpdEpuZTc1T0tZQ0t3?=
 =?utf-8?B?VHBUayt6a0tZQzdDckFpR0lDK2VST2FuV3Q2VE42UnM3NEFOVFY5V3NDdTQz?=
 =?utf-8?B?WUQxd0FDZk80V1o2SlA4dTRaWmZVbTlpT0VjT3hHVUFiV2l0VXhCM0hCbXBH?=
 =?utf-8?B?bU5IbnVMdXArVTdMOEkwTUlCeUFqd3pPeXJDRlp5SmVTbXdRWDVoY0d5Mmsy?=
 =?utf-8?B?clI4NFBTWXRDZFFPUE5YOHJkZ04vL05qU0czVDJ3SHZhR0RJcjAxNytta3l1?=
 =?utf-8?B?REEvWW8wZm5ZaXgxMWRxNHVUcWtXNVovcVc5TGp4K200ckJWYm44RTAvdnZL?=
 =?utf-8?B?VWNhUldmOUtQNmcxSHVqNldZWnk5QzM2SjJrdzZ4L0xNSDJhSVVTZjJ4bkox?=
 =?utf-8?B?RFI1NnI4elhQV3JoUFpHWk83ai9wUEp3amJsbW5rNTE3cWFIODlFaGpGMFJ0?=
 =?utf-8?B?cUY2SUd3d2NOV1ZEclh2NURsdUcrZW5oQjJNVVFmUGZ4Y20vRVZWS0EvTXgr?=
 =?utf-8?B?MkpvYWdSWTZmUW9sVkQwUHBKM2ROaVMrNWw5cGpEK0pCdlNZZklQS215eHF4?=
 =?utf-8?B?bXQrVExNN1d1MlUxOGhmd3AreE9GT2wyQzI1MGdhc0xPNUVFY2M0d01JRjRV?=
 =?utf-8?B?cXZ1UExBVnBmZk9ESmY1aVk0VEt4bjdBL3NrbkZpMTZEUkd5Y0hiN1Q0cEtt?=
 =?utf-8?B?ZDNLcnV1Q1grY1FDaUNEQnV5RVVIdHl4amtvNDVIa2lnMU0rdC9PQnlpS085?=
 =?utf-8?B?dDE4NjlUMWZRUW5PTXhwLzVrYXExMm9GNEx1bVBpdG1DMHNaMVl6TWh4K2VE?=
 =?utf-8?B?bkpBdnlnQmxKNklHTUhnTGY2VnhOVDZqWmI1djBqejQ3Skh4UkZiU1BOTm5N?=
 =?utf-8?B?eWNRUEFtdDlscGRXQmZNdnFlTXlIczJFbWZYZzVBTWZ0d0llMkVnZ1RPOWQw?=
 =?utf-8?B?SmM0TThTYkFPbGovODdOSExKdU5lcHRPV0s2cDNPM3NWUEhuWWxBdE9vTzBi?=
 =?utf-8?B?SlU3MTVBTDU4MlZIYVV1TmRSYi9ZOUYrY3JqZ0JqRkt6ZGJYTGRkMVdXbGVP?=
 =?utf-8?B?Y2JGemovZFljaUhLd0ZGaytHSGFxdWt4T0RhclgrMDg1cDczS2RtYk45YnAy?=
 =?utf-8?B?K3pBOGRtL0svRFhrY1lYSFVhdTdrQStHWmJCRkxYc3ZRdjhIMnJuMkl6aSt1?=
 =?utf-8?B?MnY2TTF5MU53c2tLbUhjL2pkQXRmb01ldHFhMG1Lbk5IN29PQU0rcHZMSE5j?=
 =?utf-8?B?QjZwSSsveWhPMGo4b25ZaEVCYkdCcUJ2a3JiY0tmNFdXZXgyaXNzV1JQR2hN?=
 =?utf-8?B?UEZmTVNKQld2RTM0Ty9RMlRxVjFYK05ia0V3VTVZUlh4M05HU3RidE5zSGhD?=
 =?utf-8?B?OHBQZGRtT1Q5b1Q2U2lCeTBnLy9hMTBCVUdaWUFnVW01RWhzZ3RiTE16VXRr?=
 =?utf-8?B?T3FtbFJzMTR5akNMQVFhOFZaY3ZXZG8yelN1eHhpc0tzR29qVXpUOEZRMWxw?=
 =?utf-8?B?d2tPc1NNV0k0VjhGbjlrZ1hrU09yY0N3dFhjYVBPSnhiaGZ0TDR1N3hwU3pV?=
 =?utf-8?B?ZTVSUzJ0bk52YUNZbGxSVy9CK3ArcHJEWVhEQS9qTzNNdlpYKy9LWFZHK1JX?=
 =?utf-8?B?Sy9IS0VURDZIYmdRbUlXbW8yVC9USmlOM3dTYXRFVFV6cTZjYjhjbmNMTWhz?=
 =?utf-8?B?WjJyTk9pRURybE1qK1JDQVZHalVQZmlXNGdIaDg5NndFbnhQWTJWUWM5TURB?=
 =?utf-8?B?SCt0OUtUSVFiOGhtWGsrTC9COERMa3BjVTljbU41VlhKd1ViUENuYkFKYndl?=
 =?utf-8?B?K1RMaXJwRXc4WGQ1Tk9KWVk0ZlA5QnFaNnhxZGJnWEJDZk55SWY0bVFiU3ZS?=
 =?utf-8?B?TkJKRmx6eUlaOFhYb1l3bFlYTnFEeU54dUVlZWdNdkc1ei9ySWNRbWVjMVVD?=
 =?utf-8?Q?2HaNj1M3TeT9P9GHZzNCZeZHz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f97937c-ff8b-46e4-c5b5-08dd75bba67f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:04:57.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OYSQrMATQGFxa3PEpiBc6DztPqmjKT/CRM+6IruWfW9g8aluoYAfhmwlIcuQR6tqAPtS1mhrU8JERZcTQLOUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638


On 4/4/25 17:03, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:37 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Export the capabilities found for checking them against the
>> expected ones by the driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  5 ++++
>>   2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 05399292209a..e48320e16a4f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>> +				     struct cxl_dev_state *cxlds,
>> +				     unsigned long *caps)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
>> +	/*
>> +	 * This call can return -ENODEV if regs not found. This is not an error
>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>> +	 * mapping them should not fail. If they should exist, it is with driver
>> +	 * calling cxl_pci_check_caps where the problem should be found.
> Good to put () on end of functions when mentioned in comments.


I'll do.


>> +	 */
>> +	if (rc == -ENODEV)
>> +		return 0;
> Hmm. I don't mind hugely but I'd expect the -ENODEV handler in the
> clearly accelerator specific code that follows not here.
>
> That would require cxl_map_device_regs() to definitely not return
> -ENODEV though which is a bit ugly so I guess this is ok.
>
> I'm not entirely convinced this helper makes sense though given
> the 2 parts of the component regs are just done inline in
> cxl_pci_accel_setup_regs() and if you did that then this
> accelerator specific 'carry on anyway' would be in the function
> with accel in the name.
>
> 	You'd need a
> 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
> 	if (rc) {
> 		if (rc != -ENODEV)
> 			return rc;
> 	} else {
> 		rc = cxl_map_device_regs();
> 		if (rc)
> 			return rc;	
> 	}	
> though which is a little messy.


That messiness is the reason I added the other function keeping, I 
think, the code clearer.

Note that other function is only used by accel code, but I can change 
the name for making it more visible:


cxl_pci_setup_memdev_regs  ---> cxl_accel_setup_memdev_regs


>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +}
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
>> +			      unsigned long *caps)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds, caps);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, caps);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))
> As before. Why not just mandate caps?  If someone really doesn't
> care they can provide a bitmap and ignore it.  Seems like a simpler
> interface to me.


Not sure what you meant here. This is not just about knowing by the 
caller the capabilities but also mapping the related structures if present.

The now returned caps is useful for dealing with mandatory vs optional 
caps which the current code targeting Type3-only can not. In other 
words, the core code can not know if a cap missing is an error or not.


>> +		return 0;
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map,
>> +				    &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");

