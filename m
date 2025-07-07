Return-Path: <netdev+bounces-204555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D92AFB233
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7995D3BD291
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49F296155;
	Mon,  7 Jul 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ln1e9Wni"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B1275AFB;
	Mon,  7 Jul 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887489; cv=fail; b=ZhzT8M/z9P69rDKUykIfsTZi1BGM0Ur/Zv6gQxuJAicKIv81LZyDDhQ45B2EJAbDLsJcjpJkTqKXlhOSHdkB8JEmmkoHqbGgwsXB3+1X2qQmQgjSmpjacJbeJKi5t8nlhzP175hK0Wjl/rhqEdk4lm76unHs39Y/0mkIPZfi9Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887489; c=relaxed/simple;
	bh=MyE9CBKPqK/8urM5ZSuPUn9HCXejnYK/cQmnHFqaHDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYPglbBxxGyT6oVpGDNb4SCzhvTLrGNdypH1Q1w3YBiacoTNe/sbYjoaoF8jWDjT34xoWuH9Z5nWH5MFmStj+9Kjjd4sq9etDyjPNx+TNJtMfYOCuHEH8GfHHcI+dqNB2nL4zVlnJfLqSF4CSJzNeOpX1V1hYb5/GwZNkjWio2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ln1e9Wni; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxEhPv6iEbnhJjZ9kptuj1OAIc/uE8spsuXw0ExZYmX9j8zAi7CNfWzBEQ9ew/PmRN6LzzWwnADtk3LOhUvcJpHnDxJpiqdmePscP6EjeuW9F/++bT/sCgTvnx5Vu92zLRSD7OBD5JRA6eG7n2twjJ41v160R6qPZd6CX3Jx5W4zLap6DDFyPONbNnK5BdGPkm4lbMz+MQtE3lY9PN1sNp3+z8qJfG3ZlFvK/aWYPrIK2tqF2yNRBdXvCVvIGS0rNDyehYl5HVNg8+0RhJG3Y8BCs/phMvhhpeGHhiotBbTp5su2V7AltN3y9dXrzEnjjzjqE6zGDUaNmJU407qPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPFQFVqXXp73tjTkzxGqQFl1wP/Y/d2GCHLVwgj6V7U=;
 b=wC8GVKpay+NLbDNqcRXMLuiETCBxZbvSE9sOI8uo9WnNMEE6a4WklTdwSDdnkigzu6I74BiGnF8UmpmUeRUweUD7I/pIbm6nin35DPVaExFJ0Av+rVj+jKHMt1dzZV4di+kS17YhR+B43cAgX++NS2ih170qenUPoxHL5pGwZqeUuosFvRDQ1BDhCGkZDEf1OMlh2G8brsnO8o6drmlMvdbHqgX8qzhV2F2Y/iJeQTpYJ6nju3NQzoxMrTWMQazE/olDrz634PeT8FQWpcz23YjU6FD1BEUeYaYHylZFtf2+1umsQrTOCYGfwkievvgqq9rVJENrMAAHHWu8uGFleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPFQFVqXXp73tjTkzxGqQFl1wP/Y/d2GCHLVwgj6V7U=;
 b=Ln1e9WnimAdPhxkhESRJ9TeeiRyrRm2DmO8iQ65Or6tpbbYacKUtH0Ga5+os49Ddgl0YmMNaGTu+7r25xsAey7rf1wWGyaHoEmEa9ftusbYev8X51YUmaF9I6SuDPRwihrQ/K3C1gojaspKIrBIp4oEQbO3NIUM/PrlJv/lLJI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 11:24:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 11:24:43 +0000
Message-ID: <f4fea66c-8c64-43f5-8245-0533b3828583@amd.com>
Date: Mon, 7 Jul 2025 12:24:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 14/22] sfc: get endpoint decoder
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-15-alejandro.lucero-palau@amd.com>
 <20250627101115.00005c40@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627101115.00005c40@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: e610a1c1-129f-4c10-07dd-08ddbd48df11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEt6M2RlQ09jdzM1QXlQc3FsWHRPc3VQakJScnUvN1hYRUN3R3JDckJpM0I2?=
 =?utf-8?B?dS82NUR3V2NDZUhvNHNuSHorQVdRS09wRGpiRWd1dDJtQjFXSFNDd0hJSity?=
 =?utf-8?B?aXB4VktUYjZBcURjSWd3ZVBMbWpRZmJTcXFaMWd0RFkyUXlZMkwwUEl6RzBQ?=
 =?utf-8?B?eVVKNEZHVlhPVUtkOFd0THN2dG9OV2lER2VUK2FKNy9XdGRieThkcldPeXV6?=
 =?utf-8?B?ZEdTTkFBYjVJT2txaFVCdS9Fb3BpaU9LSkhHc053cWtUdVFoajNHZE1PdnBw?=
 =?utf-8?B?bHBtRnJscEVuRnhlalJtUGt6VEFHR1M0UmVRc1M5N0QvTHRjSWNRMFpSNFJy?=
 =?utf-8?B?NGJXTW0wak44ZGZWYW82dVZlaEF6endwczZHcU5wREU3N0ZRWjBzanRYcTNY?=
 =?utf-8?B?cC84cmNqYUZGZGo0Y2FYdFVhQjdnejZ6dDlDZndvcWIyL3B0bERzNDM4VHpx?=
 =?utf-8?B?VmlRdjUzQlJJNEdBWWtaeEROc2RUcnU0K0wxcjlPVndySUxiSCszcGIwZmM3?=
 =?utf-8?B?UTlMbjhoMnZrZEFqMW10NXdpcWhPZnM0aG9VZm1lL1JTM1Zjb0trdUZ1YzNy?=
 =?utf-8?B?UmFORHAxOWZXTzRteTVxUHYyTlZBZGhvaVhqdW0zMVdCcFRVQlAvZmZZWkhz?=
 =?utf-8?B?UDRCZ0RMaEdiUjlGTnVMZml3Q2pqRVNsaDB6RWdualNnSVBoZWc5M2JGNU9w?=
 =?utf-8?B?RTdpM0FzZnFEMGErbktqRWsySTNKVCt6dkllZ0RGUUJqeXoyRG5mTzQ0azR2?=
 =?utf-8?B?b2FTSU50aHJGUkw3dUdXenBNdHhmMjRjcllkaFNJcFBjbmQ4RVZvS0RETmUz?=
 =?utf-8?B?cDJEemFqWEkzbWxpNGVmWm9ZRnhTN2RyMExiSjNrVklSdUx3MmhLbmRpRmN6?=
 =?utf-8?B?MWx0TUJvUnhlekpxMnh5dDFwUkdHc1A0aTh4UmNvNzh1ZjZDZ0JJeEc4M1p1?=
 =?utf-8?B?b2ttaEFsOTFDTHpBZkJjdWVYdmNMVHAzYnFzeWVRYjRoM3lxaTMzeUNXSysr?=
 =?utf-8?B?ZCtWblVDM2NlRmM0Mk5VemR1WXhmU3FEdUUydWZPcURRVk43ZERBODVzblZZ?=
 =?utf-8?B?aTVCWWI1bjFnUHphbk9qRU1Kb1piYkJGbi96c0FmV2xkZ1dxSEV1S0ZEdjBs?=
 =?utf-8?B?dzhhMUZYcklUQ2ZQZjZFd3gxR0FkY0FPMzRUckY4UmJqYUcvWFJxMDdnYnk2?=
 =?utf-8?B?dm5xRkJBZWpSU0tKcXRRU1hSWmlBT01UZnFjVTRDVVMzR0hlQll6NmJwWGFC?=
 =?utf-8?B?b0Z6YjdKUzNvK2prYWhWNWZkRWdoeXJnSVRYQVdCT3FvNitIK0dTSkNtQlhj?=
 =?utf-8?B?SjBESDFoNXFSM3VwaFdWTlZWRFkvMnI1RmJrWVJyZWZHWFBiZFhndHFTS2lo?=
 =?utf-8?B?RWpZMTlvUHVEMU42UG5lS3F6V0dDVzZrTDU3V3gzY0lrbzdjYVpIZTBCS0tU?=
 =?utf-8?B?bHRpc0pkamlYSGhtMlZyS0NuaWt0Z08vRXJqMy85Y01zUXI3RG5OaEkwMnYv?=
 =?utf-8?B?WTJVaWJiL1BrTXdrZzRnYWdIU2ZCZUhGUjhWczlzL3ZFZ05sVEVOUjhWSU5L?=
 =?utf-8?B?dDZ2bXZKaUlGWjlFZXNteGZsenpaTVpEVE5lSHVKd0l4MGhrOHg1Z1RpR3Mz?=
 =?utf-8?B?dm5wOEc3UVhNMk1mUlpzOEFSbmhwOFBxYXB1dDN4MkYwNTJkOHVRZzE5ZXFj?=
 =?utf-8?B?OEFLTmN4UHJRZ3VNMEVYZE8rbEwvUFVzUmluSmt6Tk1nU1pkS0g4dE1ET1ln?=
 =?utf-8?B?ZFZRTXU5QitDSTBrSmIySjVkV20rcHRJT0IvVjhaN1hwZ21PWnR3cUJTdGFU?=
 =?utf-8?B?bStVSk56UmpTVTBlRGZVRk5ZQlk1SG5MMFE5cWczRlFIUmhtN1BZYXBGWExQ?=
 =?utf-8?B?SEZsTEVqNTMydGlnUkNob3VoeW1lR29HTkRJZjFrNHAwa3pPSjlMWUh3bEhs?=
 =?utf-8?Q?JhK4xYVCPas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9laEdjMXRKdSsvZDZGVDBaSDltMkJtSll1WFZtUlprd0x5SWVLaG5Md29P?=
 =?utf-8?B?bjVJa240VXhsTDVJaEs4d2c1V0l0VjlZV01pdjNhNHBabFdoWGw0b3U4b0pW?=
 =?utf-8?B?WnZPbmZQZ3RLbk1rdUk5ekdpNHJLRmM5aWhkY2g0eUJRVitPaWh0d2p5UEJH?=
 =?utf-8?B?NlNkN1FMTzc2WHBYTVZoeU9vZE5NV200a3VObys4dkIwRXdqeDRZR004dERU?=
 =?utf-8?B?Q0tjS2o1d0xEekh2TktLckRhOTF6TjdCR1hKb1ZPZWRyWGliN0pEcmRVbjd0?=
 =?utf-8?B?UUpYbHZ1dm81dDczRjFab0NxRFIvVDN0dFJEdTlwNUd2UGg3TU80ODBqOGdP?=
 =?utf-8?B?dyt0Uk1NVzZ3bXdlejVJZW9LZTVkSndtS1BmOStGTHBDQnVPRUVxamFPK1N1?=
 =?utf-8?B?RlNUa2NObmJRa0NQRGRZUWpsdHIrdHpsT0QwRHRrRHN4aE00WUVIK25Kdkli?=
 =?utf-8?B?MGx2RE9TV0VWNUp5S2xkL2owZE1TeU1aVUlzU3ZDbnEwNXlnZGZnWTQ1MEww?=
 =?utf-8?B?VG8xRjhRSlhMK2N4WXE5MzJnZUJka0ttai91K1pFcGU4NGxFeDhCdldzZDNO?=
 =?utf-8?B?L2c2d2Mrb09rVDlxaWNoTDcwK3l4dnd0Q3dnRmpmSmlFemNCendOcDBla0w2?=
 =?utf-8?B?L3pIZ0tjZm5HeCtsbFVlVWtQVnBFU3NEZUVXRGVna0FVc2NuQlFHcW5zSE5v?=
 =?utf-8?B?MC81YzdqamEwcEFUMzArajQ2Y1IxYk5naElwRkxndEN5TjY0RmdwN0tQZC9l?=
 =?utf-8?B?NzNGcUp6U1ZQT3R4T1hUZjE0aDVwYWhJTnBGbkF4a24wOTFDZU9YN2k5ak9z?=
 =?utf-8?B?M2p0SENqSm9wMTFkZzZMWEZTajc2VnJwRjBZYndXYi93VUpkdDBkcTF2empw?=
 =?utf-8?B?MjFFLzVWSldzellUcysxdVhPUFJnY1RPbHpOdHpWeHhNUVk3RmJmTjZlaFRq?=
 =?utf-8?B?SkV3bys2Y3h0Zm9CMXVqb1l3aVpWclhYOWNFVmFQNG1mRkRRaHkyY2lwbVJl?=
 =?utf-8?B?NjJNcEc0T1pwaUMwY2hBemJjbnhXdVE4WC9aYTBFc1BRWVBuVWxyZHRlcTg5?=
 =?utf-8?B?MlR2S2ZTVWZkaEFFZGg3VVVob1VibXcrWDBHSGZjYTdYS2ViSXdGWTYzSDg3?=
 =?utf-8?B?MFZsWDRCT0FzeTQzSVlUS3FidStFTzRjMThYcUg2enNIcXlLcUNCU3k5aERB?=
 =?utf-8?B?Y0tJOVkwVE1HVkxKeDZLQmh1T1lKY0Qrd3ptcE5SYzVPQnBiVjFpS1lkS3pu?=
 =?utf-8?B?OWZCWG1hcEMrK2l5SkhWc0l4Z29ybUh4VXdSL0dwWW10T3RreTRqaXg0ZE5E?=
 =?utf-8?B?T051QUx4MzFvaTdESEFoUU9jS0QrbWc0cXdaMndLMG1wcGkyRE4rZllJMGdT?=
 =?utf-8?B?NlhIWTZ3R05pbFI5UDNLRE8zN2dlOFhBa2ZGYTVKUC9GR1JPL3RmZkVZR2Fj?=
 =?utf-8?B?dWpjZmxDL0hVM3N4VHZuK1hjSjRUc1N1Q0lKM1ZRcU05UG1SQ3c2di91YnBo?=
 =?utf-8?B?a3NZOWQ1cDNiZnpEQ1pUQTVFWUZiYUcvVUJxeGdUc3kveGh3QmsrQ3hSQ3pP?=
 =?utf-8?B?TDhrQ2JQSThwZW1ZZXdnc3NiMi9WbDFlRHNaUlBIZi90OXRsVnVkYXYzWGxj?=
 =?utf-8?B?UC9wRW5FaHF6dlNjeEV6YitMcVBaUFVUeVlXTzBGOElJZlNiOExCdWdMS0g1?=
 =?utf-8?B?c0EvRnFnNEVjdE5YL3hzaWxsam1DUm9CZFhWN2RNOGNURzVmVWtnWWhkQTV4?=
 =?utf-8?B?Z0VpMmdRS1F5RmdWV202bjFEREt0eVZhcDQ3a1kzdms0NzJPdDdQQVZrUXRz?=
 =?utf-8?B?NThWbXNUTldqd2dncXJ1b0d5SFNiRXhuNE1lRWxXYnRCZkx4dnUySjFtUEpC?=
 =?utf-8?B?RG4xT0l3QnhtWXMweGJoSm12bThvbVptVEJlZWZiOHlpM1BjKzIyb09mbjVJ?=
 =?utf-8?B?RVBmQ0JJUTdNVUk1bGx1K1Z0ZkoyMm1uWHk0TG5LeUVjMzV3c3FCUkhVZUZR?=
 =?utf-8?B?N1dFcjB4ZWhYbm5uanBXaldLNktwK2o1NGU2TGhnVEN2U3VMcjQvOHorN3dj?=
 =?utf-8?B?WE5sR0lFOTlSUytUbGM1dThBSjlVVzJjUGhpdGNkbjNyZVVtelp1U2ZYQVo3?=
 =?utf-8?Q?PAoCMTlckR/BfIZrXb1PS4Dya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e610a1c1-129f-4c10-07dd-08ddbd48df11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 11:24:43.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lheVTgJfU41AVwLsq8vkTpgYz6148frF7BgO2IjQEd2qPec1VRrBSadGnTosEwktOwIvHI/bJx9mk3yjhNzcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045


On 6/27/25 10:11, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:47 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index c0adfd99cc78..ffbf0e706330 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto put_root_decoder;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR(cxl->cxled)) {
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		rc = PTR_ERR(cxl->cxled);
>> +		goto put_root_decoder;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	goto endpoint_release;
>> @@ -121,8 +129,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> -	if (probe_data->cxl)
>> +	if (probe_data->cxl) {
> Given this is going to get more complex I'd be tempted to go with early exist
> approach for !cxl
>
> 	if (!probe_data->cxl)
> 		return;
>
> 	cxl_dpa_free()
> etc.


It makes sense. I'll do it.

Thanks


>
>> +		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>> +	}
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

