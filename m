Return-Path: <netdev+bounces-238845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDEFC6017D
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 875524E1FA0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05F23B63E;
	Sat, 15 Nov 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AJy13UxQ"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3A10FD;
	Sat, 15 Nov 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763194378; cv=fail; b=pEfNjnRInFncivNssr81hgBBf7uxh0RDXNlwLO1EvUrG0ffnvgFOjRbEsSKBkQUI7DN0M/WLnjCM9rImk1wkGmU0hsJYT2aRMk9Q6SPfKfbTLbqv6bwlAbsqLZmmfGIyE2q5LGOXpWcx3HNBzqABRfhtDnaaCtkstNBRPvK9zE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763194378; c=relaxed/simple;
	bh=jyyveoKb65Ualo5dxfaO9iVtvZ4S2nT58E04SmKnwjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWurjZI1CBWzHCOqXIYTTL6VZS+1WYyM6LSqqX+Ihh6cga8rCpCBnWiUgixQUZQYOBfxwPMt8H8PQkBwHQP6EnA2JlhP4zGLnBHteGlVrNQrIp1fp7hFv70b1zdqG/49mWuqg+XS6+9jnmYkc39Ax6F/t0/ooBDaZPQ/AY9pdUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AJy13UxQ; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGQiESaiGDONzgIpsk4ZXIfS5oR4g0Qpfzfj2871coTN2evYPIp7Os73haLDZpVT3kwtJwfx949YW24faad4v9Y+TD/A6n5wMrhu6s3Ep+yZGknvMhFJ9n25p6OUVX5tOclcZ1R/LriWLHjey9OEBRNnl5yCeaSt0ZTAwkUOsCkSbBO/kQdMgY4W8X6J7VnvkhNkh4mWV+S7G1zU4O5uGPD7f9pbPKmxXoebgD2Ut405HlaYu/fbQDIy8VaTAw6G37bRgAyYp90hy0eUlxJMT7Jrnj+H8c49yCZA0s2vpcc/VZIK1zewVGyXQ87c1TkRjdKPXaza0eob5MQ/tOgN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BNV888aGsKl+VVMPflC7/RyL9TNaz8rvSzbgjmr8Bw=;
 b=j0INbDTBB7sN1BaJK/r+kB9VY5VUwmfuRyJWVG5mYy7gJ1xV7oKxGp4GahfX6t6LeZLFKwSaM5x3ulkJKvVZN4diWIyS5f+cu8gYnkIaXsEWE4ORbS0whgxP/s5BeXy+bZxWQ5fLw5RGDltgRRUXEwMMec9t2/Z/rOek9kVJY86qHUx89pQSpDLfxxvrKQ4mPeeTTAYB1dUIXJPPm1z6DLxB0zca1PfzQ6hWpzFzZQz/VjY78nS48CESTbKyhJZA7ZamFyLayIl72SBh57wi16lgBoG8NsfVewpIg+b2DB+qDCf8qGxC0q/KhorZNCaNwqHDDLBn5cw3v30+9MqeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BNV888aGsKl+VVMPflC7/RyL9TNaz8rvSzbgjmr8Bw=;
 b=AJy13UxQQjYYpIGuMvAwoKQODBvnCl/b+lRhNE3Q0HgM+Luo4kWrFPGXymSI5zsW54qrpO6HUJDjhLbHO0+HMekBUIzTSOwlC65Pko3cXyheIq0nfFCM4BkQqX426Oq3XoeMhWEImary+Hfvq3QTQMNkcmc77k/PKCpHhEMPWUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 08:12:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 08:12:54 +0000
Message-ID: <8d0b9a21-c1bd-453f-903b-22aa302b3639@amd.com>
Date: Sat, 15 Nov 2025 08:12:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Fan Ni <fan.ni@samsung.com>, Alison Schofield <alison.schofield@intel.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <20251112154103.000025fd@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251112154103.000025fd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed436b-6eda-4816-7279-08de241ec6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Szk3aE96SEtuUitNWS9nZEVMb2h4dzRnSkIrOUVtMlRCSTFCcXVmNjRVMUVG?=
 =?utf-8?B?STMyMTVtL1RzWXZnejNJM3pKRjJoMVJhWkZoVlIwa2lCNDNnUXIxUkFINHpK?=
 =?utf-8?B?eVloMzE3aGlVa0tWbitXWGFPNFA1dHBXVytNSG5oWDZSdmxYdk0xSEJQaDZB?=
 =?utf-8?B?M3pBM0hCZi9rSHpwaTFUb29QYk5jdnFIQml3MEQ3ZTdwNStobDZpbWxOV0tM?=
 =?utf-8?B?SkZwdFNhaFZ3MVYrSjl5cjRXVFltYThKdHRiVkh1QUFGSkpnUGRlZ0hZMTJW?=
 =?utf-8?B?V0x4c05EZnZYT1dZTVo2RTNsZUJpOGZ6b1pQUEZMRUNMQkx2b0F4OE9HVlVs?=
 =?utf-8?B?am1jM1I5Rk05M1BwQmxxZlNJaXVxT2dEWE1MQzM3Y2tYOGF0K1IyVFdRbzZa?=
 =?utf-8?B?bzZIYTFkQ3JoZDQxaW5FdE1xdEgrajRpWU54U3BLNGk2TmZ5aDNxb0I5REta?=
 =?utf-8?B?eXQ1bVRTVFJIYisyUGowejJIZng3UjlJWDVNM3d5UXJnbXd4RHpaN2kyT3cv?=
 =?utf-8?B?NjdaVjE2KzBwbGQ2WlhCVTgvMGlGVnNoZlYzcFhMQ3RBOUpjb25aeC9GZFNr?=
 =?utf-8?B?UGwwOUtESjlVVERmSlBCb211Um9tWkNhRmtYTnE5QWNQMUQrZ0FsWE9UeHIz?=
 =?utf-8?B?bU9YdFZGRUd4OUFEMld1ZEhnNUFzalVFa01vQzc3OGYzZ296SWFLelJLcHZS?=
 =?utf-8?B?bWxETUIyS1NURDB5TEpqalNtTS9nRm56aUw0WElTNEN4alBDanNwZncwMXZl?=
 =?utf-8?B?eGVESE1rQnIrbm01UWpHTjZ5WWU3WWlMdTAyZGZOazYxSmhYQlJQSkxDMHd4?=
 =?utf-8?B?R0VxVURJeU9UdmphaXVQVEI4bG4ydjNoOTRJYXBMMStVTkpwUy8rdnNWaVY0?=
 =?utf-8?B?aEQ4bjdsMGt2VE14YmgxU1JsZHN5T00zLzhlclQ4ZDBMRzlaaW5lcGhrdUlM?=
 =?utf-8?B?blZxOHRhcUV6TkdTNUFROGJjdVZIRGVaQnJ2YUd2TVRxa1BoK2thSFA3MU5C?=
 =?utf-8?B?Ykt5OWphVXpnaUxTN1NGZ0NzVjhqQUlRTjBtMks3eGIzTXh6VTdxSDZSSlBO?=
 =?utf-8?B?RGhTeHVyTGR4QTlOTE9tU2lFamt1dlZPbWlWSGxsY284aGRYNHpVYnJyTVFZ?=
 =?utf-8?B?Und3bVhONmwyQTV5bEJkMElmUlRxVVZSMzFVU0Jka1F5Tkhuc0ErN0NXcC9w?=
 =?utf-8?B?VE1GRlliSWJQL0g3ajNtaVRITEdhOGhRd3dGV3F0bE00WGlxYVVGeVJKZkF5?=
 =?utf-8?B?dCtCQnV1eUpnbFV3bWo0TEIyUkcxMXBkZVBLZzQ5MjFVTFVJMklDOWxBQ0Vh?=
 =?utf-8?B?RE5peGx2cElaQjBhanRrTjJMdVJ6ZGlRWTRYU05kclg0c3lHS3dXWWdvSWli?=
 =?utf-8?B?ZWQ5ZmtGbTdBaDhlN0hiK0NDQjN5YnVidkpBQXEzQ2ZseTFvTGJKWUxYdlUz?=
 =?utf-8?B?WTRQMTJGVnhoYW44cExxa3N4RU00QmVNa0dJRlNIYVhKd0NadjhWSC92U3hk?=
 =?utf-8?B?aC9CRUFQWnhkUWQzVjZZdnpnUHpxWWFrakhLZlJlWnE4N01idi9VQkhPZEE5?=
 =?utf-8?B?NGlnOVozdmhhSnFCbmpWaDQ3UnVWM0hoNGhIbnZHOU42Lzh1TDhvSWg4YXVJ?=
 =?utf-8?B?T0VkRDcycEJOTUh4aFRhbFY1ZCtmR2RkeWlJL3lCaG5mZ0tDTVFQNlFCMllp?=
 =?utf-8?B?eDQxRjZaVnpETXFMZFJ4VWx0THVnWXdsRE8zaFBjcXFROHE0ZzhPSDRRWDRw?=
 =?utf-8?B?WkYyMGl3L2JmTG5HNEdOcmlvL0t2L1BZVXVVUlNnQ3YybVdjZUYyTklHdi9H?=
 =?utf-8?B?b1k0QmpSUjNTOFZLQlVWUENBS1NJR2N1WTU3SlQ0bVhHZUJsaTBXMWNsbStT?=
 =?utf-8?B?ZDNzUm9QaFUzMVlFNWQvQUkxN2dxd0Q2bGF4NkREUTJKa045K0RPT3FHM1dV?=
 =?utf-8?Q?bmSlp4vBByyV3xg+VCLkmo0Cbkexi3l3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEovb29aL0RYei9DVENmUm9VblRISURLL0p1cit4cHdLYXlkeG85R21GUGVQ?=
 =?utf-8?B?S0FxcjcxbWNnWU1OZGFIY2JzRWxJTEpZcy9VRWRQVjM0RFNxUm9XRXUzeTNP?=
 =?utf-8?B?emFkNnhCVUV5ZFl1M05qVDIrZFY4TkkyNWhBQzBYNVdZTlBFTTNtcVlKb25j?=
 =?utf-8?B?NlpqbGxUS09HaGp0aEVDMGlmRURkUElKVzBoQk81WkRWektuT29TTEN6RnJW?=
 =?utf-8?B?bVJpem9saVRoVVBIK21pam40SFk0alZqYjFJOWxtYkhBZmFtZkQwM2hOV2NW?=
 =?utf-8?B?ZjVyRGNab0tNUGthTHpNOE5YbmtNUGFCWW0xMmJPc2hJaFN0VzZvR3oxUDhh?=
 =?utf-8?B?MVJKWTRvZms3cHAwUjlibjhrL25IeXQ3WFdnZ2EyNVVVZ2ZlYlhBWDE5ZVRC?=
 =?utf-8?B?b29Ba05selgrWldsMGFtN3VqRWN3MDNkOWZWbGpRUlk3c3dUQms1TWRReFAr?=
 =?utf-8?B?dmQrSWZLK001dTlyeUZsN3dMb3NITERQdy9vT1RXT2xYL2NLbzNybVZreXBl?=
 =?utf-8?B?VUFNQk5HMHhVSThiZHRLUFpLc2k3T3hqL3ppVVpHMzlXZWh5VW9XR2RFS0di?=
 =?utf-8?B?WHlZL3haR1daWHhKb1BsMm81UzhaS1hDajZrR0F0bFFySGtRZXppY014dHRQ?=
 =?utf-8?B?cGk3eEVDZkxhTDA0dmZqYWpaTysrbmg1cisybndtd09JVGVWUTZxNkE0OUhF?=
 =?utf-8?B?cENiMy9mWFUxUVZzbHpSa0p4WU9aVmFSQ3lmZXFWc3ltL0NnbHN4elhOK3k2?=
 =?utf-8?B?WmJsZkFtd1FwRFlzQWpHaEJqRWlKb1RSV0RYQThNQXEveCtINDRiN0paVXpT?=
 =?utf-8?B?WC8vQmFVcFhXckFpdHpYSDdwYVlMK1Q3SzNzTEQva3Y3ZnRRcXdtd2h3OXVx?=
 =?utf-8?B?L0NyU3h0SFYxeWlJWkxVZUU1NzZtN2RTeVBUZk55eklxN0pBeXNOYXliUDhT?=
 =?utf-8?B?L0kweDgxOXVPVWR1a0RtNVkyWktPS2ZRWjdnZG5nallSeHhwTEU5Mk9IcWV5?=
 =?utf-8?B?R3YvbkhKWmFOajlDM2FPQ0lyZ2c2cCsyYTdNK2NkYTVUYUpOd2FqbUplUllW?=
 =?utf-8?B?WGlVK0xENUl6L0ZoK05SNk9mMDVjdmVtUVpYaWxJazlGMzE0R2ZvSGhCcFpy?=
 =?utf-8?B?OTZBaE9tK0E3QkJxc0NxTGxwWGFCS2szdlVYa0xmRFdOWjlVbnNKcHlaYkdu?=
 =?utf-8?B?aFViS3NJa1BKR2k2ZjBiTVBsKzc5ZTArVitrY2VYMFd6OU4ySkx3T082WDdF?=
 =?utf-8?B?YWxkVEpYV1YxY0pRbDB5MTNnY0x3Ly90dkM0R3R1MjlTbU9TVllrL3B6VHJz?=
 =?utf-8?B?ZWpsM2p3YUhMVldqdmc4V1NoU3JrKzRmMG9rRytsRnZGcTlQZDdBeHd5ZGJL?=
 =?utf-8?B?M2k0M0ZFa3RkZUJURHFGbmIvbnJzeStOdTBkL2RPQ01Qb0Ruc3hCb1c4TTcv?=
 =?utf-8?B?THVXSEVLMzFwZ01JY3NxRTk0S1pnUUhiQUJTSlJqaDR3L25ETVh5NGF6UUht?=
 =?utf-8?B?ZDI0M201dVc0M1hEL0NLckpFOWlSaGtIWE54TXdibUFBQnFJSFAyeTBXSGhR?=
 =?utf-8?B?dVJNM0FqcVh2TFVhM1BCYXZROTR2TU42MUgySUlobExzU0lCQ0JacWxDekRZ?=
 =?utf-8?B?Y3Jkay8zZ0xLRW9JVTQwVkdJTXkwSVJkUkdaeHpBKzNJSU9WZlZtUTNvZnpB?=
 =?utf-8?B?U3ovWjc3ZnpRZjFDVjFvbi9iRTIwOE5OVi8vamZEaUwrOWFTL1p1Qmw4L3F0?=
 =?utf-8?B?UGg0ZkJvU0R2ZDNIU1BjanNEM24yTVFualhuUUt3Y1NyUjc0ZEhTWnlTd29w?=
 =?utf-8?B?VmVHaDZNZzhqTEYvVVdiWDZxWm11cjZEbUFacXFTdzlxdHdObC90RTc2NlZy?=
 =?utf-8?B?bVF1ZWFrSnNPV015M3U0NmNLdnRqWlROdWhLUktjM0dENE51NnBoRVZpZWc3?=
 =?utf-8?B?Tlc1MWhBT0hPa3lXcjgrTFRLSnpLWEZGaXJ2d1plVUFSa2gyd0prbTBlWENV?=
 =?utf-8?B?dkNkWHhDb1lvWUM2Ukk0QU11cjYzUThoeTVSOTlZVGMzdkdSYzNMakdWZVFu?=
 =?utf-8?B?ZGRmYjZzSmw2a1F0aEVwVG9rV3hnaXFoenFJVzMzVWNIeGpDSjhPRWpNK0d5?=
 =?utf-8?Q?ZStlqMYL7U63ilg2fqoSEtYye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed436b-6eda-4816-7279-08de241ec6ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 08:12:54.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIcEJXfHCd+w+IuheCdkYCKfAVdUBmA2AfvMxV2AbjiVxdApubCnnkSzXN4ZDgqRTVl2fMMiO3L8trV9/6hUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768


On 11/12/25 15:41, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:36:41 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Fix cxl mock tests affected by the code move, deleting a function which
>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>> setup RCH dport component registers from RCRB").
> As I replied late to v19, I'd like to understand more about this comment.
> If it was not being used, why can't we remove it before this patch?


I replied back then, but if you think this is what I should do with no 
exception, I'll do it.

Should it be part of this patchset or something I should send independently?


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

