Return-Path: <netdev+bounces-159816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92557A17025
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D456168E08
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFB19BA6;
	Mon, 20 Jan 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/AO7m+5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1F1E9B0D;
	Mon, 20 Jan 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390411; cv=fail; b=AQc0ANZWfYV21oElloBYtSjLkox/o6Z9XNr5dkiqx8fWyt23Ra5HjrCmfj/pViRQd3GsJvpiVIYdNzR77mWeRt+SnI7xRJdW+IkeCAwIspwxOSbi16pW7NDvr6kgFt+q0clN30wF6l30MZHZAFWy/RxVgW6GWHQrgZwmnzHxkVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390411; c=relaxed/simple;
	bh=E2FXpjrc55O6rGCAMa6mmunxOGYZeXQBRcJp+lGKYaU=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WuRsqP37k/UZ11+LoHN0JjL6L4WcnorvHWeehE+ToypLLBkzP9Sr8ZmxQK2X3yxDDggEPzpTW3eLwPr/FLiSpaUNLqw3fzQMODg39knickYGwN44zGV7AhtID1ecrLRqEyfkxTpy249zM7AbKY0ZbdNGkCivhnAra3qXh6gGqPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/AO7m+5; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0X9oAA+oavCOsUtoQWkiu6kz9zAP2memhIFOLcQdgapUye8YcdF2o67ePKY2zQNZVgoxgiRFMl3ecIy3xfkAKUqKxzdklttr2EcGxZSOftEOn5u21fSrQ3bLtJS+kumDbgGEgmjov2o08SqJx0BpqxPw+B+itIiHa2fStAe242nRmsidDaQz3tXWcT1GoxcnuLlhFUaY+ludoOVGjIoIeB8rU8GQEEwNrAhZFdXjoMhPbJC4hILyGU03b5/KHOg9J6KxpD5+9OU3fE44kZQHcVUr+0nHcy9sI9HNZEE40T3QXylAOwQGiTQGv7VSgMqT3FXqeT9ZJ5aRXi3PW+kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfuPyLjYhAJ2xxgaoP2cuDDMP+4/LJuYoHrTScqfjDU=;
 b=d7q1RrKLrWBchOj06FUyeUIi2C2dWbHS6/FQWQWraTeZov3MF6L9+1wwnZGDYlo6H6lj9yTmAFJxZFBHeoXPhIbJ8LhQDjWaAFmk5CkDJhShGKIwVl3A8Xmp5F466yrZMgffj7HiJFZq9I4d6AiFvAbLVSbVdSIEqzq9PScunkgxjwHv2js+gokqJ1YLwfXhvu4+wobK4/H1ZVFrbpvKh72kx3ucXgDESlS4Jd+zpODUoChZMTVD16EE+DHtWp0XWblOLSvnTHj4fxwm2niU3HlPFOrnPo7OQnpjz3NFuxqvvywQATWM624GzaTkCxb+u5+2FFqrm+L86xaSNtJUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfuPyLjYhAJ2xxgaoP2cuDDMP+4/LJuYoHrTScqfjDU=;
 b=G/AO7m+5OuW45tu8Zz4VjOYUadgC+cPC/2dcRDVazne9425m3nfH38W4WHGJ6vYWj2CfVc0btsYoadSumiFLuj4m06ddKeI0Qq3Q09u6dky4zUqfb0+j5oO8yQH/ZFJ+uEGQgZa+FwnOzsdkTEvket3pkL/5YB2ooAUQ/WqCwxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.20; Mon, 20 Jan 2025 16:26:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:26:47 +0000
Message-ID: <a97f50df-5b0f-6ab5-80c6-531d4654c0b3@amd.com>
Date: Mon, 20 Jan 2025 16:26:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com, bhelgaas@google.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
 <09d6b529-57f3-290f-7e92-0291cdd461cc@amd.com>
In-Reply-To: <09d6b529-57f3-290f-7e92-0291cdd461cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: cbeefffd-e953-4edf-c862-08dd396f3c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzhCUGV4TzJ4Z3p4Y25SYWpjcWVuRU9Ib1hnK1FpZDFzeTVGemVRaUdmUGp3?=
 =?utf-8?B?MU1iOGFQdy9pSUtaWkFBYXZab0dpcmUySkdQVHQvQ3VLZ2Y0dFhZNDNBdDFx?=
 =?utf-8?B?ejJNelltUEUxcXhwS0xiM1MzeEFCZTUwM1ZuQUIxcWZVN3FGSVJLOGNQNFp4?=
 =?utf-8?B?RnlmWnBMTTBrbDlXcC9UN09BbjJ5UGk5V2RUOUQ4QnBtWFBDUnNxMTNqbHBL?=
 =?utf-8?B?ZDE0RXhYRXM1TDM5aUQ4TGlxOVplRThvcFhKeGh2ZU1aK21zUEpVdTZtYWdv?=
 =?utf-8?B?SnliMW5FeDEySStQdzJ5VFNia01XdWFZcmk4OEJlQ203cFdlSW0yTTNORHd4?=
 =?utf-8?B?SDhMWlZ5em1ya05YdkRnL25oNnJTVzJDcngwejEweUVvM1owdVhnNGd0eU0z?=
 =?utf-8?B?dHVsZGZMYVZUY2pDSDc3dFIrek9odndFR0hwK2w0a2t6ZkpwbFlrZS80MDRE?=
 =?utf-8?B?T0NqUDRTMUVkcno5UncwMXljeXdwYVlCZzQ5WS80cmkrMjNpRFV4WkVpQkpj?=
 =?utf-8?B?NVFMeStnWGFENGh0S0pEUGJiWTh1Ri9Tc1NVQmVJKzlBYzBmS0tZOVZtK0Zw?=
 =?utf-8?B?R1B4ZDhFdXBuRUhMTFZMOUZBQmorR2JLTUVFeDU2QWlCVlFDR3FpaXVGZk5v?=
 =?utf-8?B?eExwaCs3d20zUEhuZzlxUWlCa1g5c2p3a1NneUg1SVhCZDlHUFZYemMrdXVE?=
 =?utf-8?B?b0VKSyt6YTVkNEpCd1Z1cW5TVXlET3Jzc3huWXlveW5JT0wzTDd0aGhaQXQw?=
 =?utf-8?B?cXM3MnM3UmwvYnNtYVE4enFZUmRjQVk0d0Y1K1RDZ2padmlyenc4UUtKWkFU?=
 =?utf-8?B?MHRLaStLWDcybVJwdmhRMkNMZ1hEWi8rRlFWamZXWlJKd2RiNllEMkVxM1Za?=
 =?utf-8?B?c3VvQjhZZGdTNFBQNGJid096RDRSbGhDdjJoaWlZSVZxcE1oZkdVbzhQVHFP?=
 =?utf-8?B?UzhNS2J0T0c2T2dVYlFHckJ6d29rcGlBQ01oRGRpVlNFL2VscEJPNFVJVjBu?=
 =?utf-8?B?WGRpNnZaZEU5ZmxkZnJmeUEwVWxvS1Z6STVNVTZYTUVaNWpLMzZlQ2hNQlRt?=
 =?utf-8?B?d1NEMVNnNnlHM0ttc2lyRGxhdXprQjRIYTdJRm95ZlVqMW95dDk1UGQxek50?=
 =?utf-8?B?S2t5OUdLMi9qTUZwU2tsaG1rTE5wMFB3NXdVNUg0am1LWlgreUM0a0kxZnRC?=
 =?utf-8?B?Mi9ieC9sZTVvbnNQTWo2YWRacGRnMVBkM1N5YmY3d1VaOUcwNlVkNFZaNFZo?=
 =?utf-8?B?SWxwQkJ3dFR4RnBudmZsMWl5MG9yeWQ1cmpmR0ptcDR4b1paS3N6Q0padGtl?=
 =?utf-8?B?a1dLMEF5RTM1Vk93OFZwbWtqa0hMR3c0VTc1TGJpYm9TMUlIRUdTczUyQVZo?=
 =?utf-8?B?UzNsa1hzdWswanl2UEdxS1dscTB3NjRHUlRYVng0S1dmZzhKNkE2MlErWlhz?=
 =?utf-8?B?UWFiZDNwbmFEM3N3QVljZUNxd3owZTI0T0V0dlFhVnd6TGtMUHZJRlovc0li?=
 =?utf-8?B?TWpyMmtobE11U1NPeGtvb0g0VnAzVks2U05Nd2lBQy9zbGdJNVFDb1dyVmo5?=
 =?utf-8?B?OXNNY2d6ZlZsOFhOd20xS2RPaEF1UGUzZmlwWEdEaURSMWthRWIwMHhRdXFX?=
 =?utf-8?B?ZEpNVEdGZzk5YlBkc3JUUXR5c0NsRkxTelhwVHEvWmpHWldQL0ZMRXdtcWlC?=
 =?utf-8?B?dHdjRVlLZGVHdEZVMTBwUjNtbEhpQjk0cXFQYzh3T3lIL1Uwa2laVmU1WXJO?=
 =?utf-8?B?TzUzS0F1bytsVDlCT2dZMHVaUyt2YzBFMjYrM25SN3ZrTkNmdUdsTHltQmtn?=
 =?utf-8?B?bkZTR1RiZzFJQzJTaWYxNGtxanNoSURrcm52SzZEalVrS1pKcjBDd0lyeDY5?=
 =?utf-8?B?ZVl0S0FnNVJWS1l3bGtVWUJhazlSYTE4VGZpTXlBdVd4QW5yL0JFK2pHcDRI?=
 =?utf-8?Q?EAFwKMpu4BE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmtmNWVEUVdHWGFMeDB4c2tDOHF6Q2NkbGJzUVBNRlhKcXl4Q3crYmMyRXU3?=
 =?utf-8?B?d2FDYU5BODF2bGRUb2Y3cmxyR29EcUJ2ZkZOUkZxRFpoNjhhaGtnQXJmSS9a?=
 =?utf-8?B?WU9BVmZmTnFMQ1V6NXFJME52cVJ5Zk5hOGhnck5NejJ2NThGOHJ0K1Npak9n?=
 =?utf-8?B?UmZrMFR3bjBMc1pnU2VLYzZSREtUUE1LOTYwcndBazJuNWpVcUg5RXBiaGgw?=
 =?utf-8?B?QXVJRGpmdTlPQVNpVUluR2l4VlNScktKLzNhZjd4U3ZoRC80VFh3S2hTaVBt?=
 =?utf-8?B?WHFPclVYUldKMjJmQnREY1VNeVVZd2FBV2hleDB1YjV5N3FjYTdiODZXVFh6?=
 =?utf-8?B?NXg0U1pTTlVmWUM5K1ZsQk1HY3Q1TGd1TElBZjFRZENZaU9sMmQ2Skl3WmNs?=
 =?utf-8?B?L25hK2VwSmpsVjBzYXdQdDR5NDVOR3VOamhYMzV5a1lDalFBcW1VZW5BVzVm?=
 =?utf-8?B?djlObFhFZGlQL1l1WVZNcHBpTVk3UVpTeEVUd3dZOE1RNmREYkNhN3Jtanl3?=
 =?utf-8?B?Qm95d2FKQzJVZm5VUjh4SFRuc1ZKcTU5cVo0TFBPTC9pQXNIYjFxMmYyeGNT?=
 =?utf-8?B?Nmoway92WkJHekJCaVhBR3oyUUoyQWlsU05uY0NQUWxiajdlb2h5dkx4MktQ?=
 =?utf-8?B?aWJqbXk3VzhiNFJGZDRTWWVJbUtrSE9PT0dZbW5ZanRGc0Vqdm5YOWFuUHpU?=
 =?utf-8?B?aE04M3BUbGptSGlHazFsSkZkNmZRS1FzYk14ekE1c1Z2Y0ZDWGdTRzhqc1hv?=
 =?utf-8?B?c24xbjBkSVZTYXRHRGlQY3o3MVNna2V2RWtwQjhzRDh5SU9RcnJPRHA5cW4x?=
 =?utf-8?B?a3FHb01iMUE5OWhwMHVaYmhRSU5SbkYwcEZRYnZEUnE4aGZyWmRCTms3dlBI?=
 =?utf-8?B?UzNsem5zb0plRTZ2c1NXcVFWd0R5UHNBa0FqUWtmczdhVHpQUVRjVE1ZQjh6?=
 =?utf-8?B?eDNLcVdNYzNYRzYzVHVXSHkxVlEvRWprN2x4aGN1K0lIdXFWN3JZclo3UjdG?=
 =?utf-8?B?YmR6ZFZMV0Z2OGJuT2xEcnphZk5CRG83RG9STEVueG00dFBqQlFIVksrR25D?=
 =?utf-8?B?VmdMU2RZVTV2eC9WL0JtbExrdWtuL3ZNQjN5dnM1ZCtHMm9jQXQrTlhWbXA3?=
 =?utf-8?B?MGdpOFZqSGc3eGhBN1Y4Zm1tSXNhZU92UlE5K085Yjczdzk1dlR2VTRGSTlU?=
 =?utf-8?B?RVFnMlBMeDNQNFNSUklRa09pRUkvaGdNMi96UDVkTUFkRWxaTE5tYmdMT2k4?=
 =?utf-8?B?RExlNTNmWGg5WXpoTjNpY0VXako2V2lGM3JwREI0S01tZFZ4WFpuZEVHL1lw?=
 =?utf-8?B?bkwxa01aQ1JnNGorUyt3cEJWbHNvQWZFeE5xTXZ1UkE5SUQ1eTBVS3MwVDhU?=
 =?utf-8?B?d3l0SmI0cVlOQ1JERTAzNXpXQ2pPNEVYMmdveUY2ZzdGMStDSWJsUzNFMFor?=
 =?utf-8?B?SWRPbldNS05VOXIwelc4Ni9lL1B5aWhJcHNZamNxbExYUDlQVVcyTW8ybXd0?=
 =?utf-8?B?ek84TTNiQk5tY0FIei8zbnpjaS8vbjZ0TEc5TGFuemU2cHJIcDFJYW0zUlJz?=
 =?utf-8?B?b1RTeW5rYy9uUCttMVBVRVFOaGxqSTNNdHhleGdJbGUzTTIwaCszbWowRVJo?=
 =?utf-8?B?QkVyc0twOU1lWERzbWtxMkhaSGtBUGFocU0zVDYxb1l4WUZiQ1c2YjBObW9y?=
 =?utf-8?B?cUI5U1VUV1dYQ3luRVhCR0J2Z2RiMGZRdDluWVhLYU0rYlVsQXVidUVCOE5Z?=
 =?utf-8?B?L0tKWHBHQkl3aDM0eklwNm4rbFBBN2xSWUlOOFJ4OTFyc0dUNWZNdjBveUlI?=
 =?utf-8?B?dXo3ZkZpTFFZbGRub2xDTzdPUkZ0bEE3emwyYzUzaFVBQ2x0L1hqdkIzTndC?=
 =?utf-8?B?VHZUS2JwVDA3S0xMb3ZQN2FXR1BnOHR4a25pN2V5K3lyZFVFNnJCVWJHSVlR?=
 =?utf-8?B?VjN4ZitnUTl2MVd6MTNSWW9PVVk0OUg4RFhRMlBvNUg4ZEpWaW02bk44N2Ny?=
 =?utf-8?B?UGs0RHY2czdsWHRyTEE0RWVpdWFWY3JmK0t0emYzL3ArMVExaWJPSmVsOUk5?=
 =?utf-8?B?bDI2c2NEMHc5K2lPOUpaeVJvTW00bTJUTTFZbTBHUE85TDB2RHpvZ1NZcUFm?=
 =?utf-8?Q?SiOTECgyTHyTedvC5bpw852E7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbeefffd-e953-4edf-c862-08dd396f3c7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:26:47.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8jmbTSZUHdXJSFyCKvbp8AhS4wiQK6U2/IiYAdhu9zHArOpJXLwh/Xy9xVGW5tPVwQ8/4UQpCvnW58z71t7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112


On 1/20/25 16:16, Alejandro Lucero Palau wrote:
> Adding Bjorn to the thread. Not sure if he just gets the email being 
> in an Acked-by line.
>
>
> On 1/20/25 16:10, Alejandro Lucero Palau wrote:
>>
>> On 1/18/25 02:03, Dan Williams wrote:
>>> alejandro.lucero-palau@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> While resource_contains checks for IORESOURCE_UNSET flag for the
>>>> resources given, if r1 was initialized with 0 size, the function
>>>> returns a false positive. This is so because resource start and
>>>> end fields are unsigned with end initialised to size - 1 by current
>>>> resource macros.
>>>>
>>>> Make the function to check for the resource size for both resources
>>>> since r2 with size 0 should not be considered as valid for the 
>>>> function
>>>> purpose.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>   include/linux/ioport.h | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>>> index 5385349f0b8a..7ba31a222536 100644
>>>> --- a/include/linux/ioport.h
>>>> +++ b/include/linux/ioport.h
>>>> @@ -296,6 +296,8 @@ static inline unsigned long 
>>>> resource_ext_type(const struct resource *res)
>>>>   /* True iff r1 completely contains r2 */
>>>>   static inline bool resource_contains(const struct resource *r1, 
>>>> const struct resource *r2)
>>>>   {
>>>> +    if (!resource_size(r1) || !resource_size(r2))
>>>> +        return false;
>>> I just worry that some code paths expect the opposite, that it is ok to
>>> pass zero size resources and get a true result.
>>
>>
>> That is an interesting point, I would say close to philosophic 
>> arguments. I guess you mean the zero size resource being the one that 
>> is contained inside the non-zero one, because the other option is 
>> making my vision blurry. In fact, even that one makes me feel trapped 
>> in a window-less room, in summer, with a bunch of economists, I mean 
>> philosophers, and my phone without signal for emergency calls.
>>

I forgot to make my strongest point :-). If someone assumes it is or it 
should be true a zero-size resource is contained inside a non zero-size 
resource, we do not need to call a function since it is always true 
regardless of the non zero-size resource ... that headache is starting 
again ...


>>
>> But maybe it is just  my lack of understanding and there exists a 
>> good reason for this possibility.
>>
>>
>> Bjorn, I guess the ball is in your side ...
>>
>>> Did you audit existing callers?

