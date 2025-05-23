Return-Path: <netdev+bounces-192985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BEAC1F81
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F593B93F8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536E224B15;
	Fri, 23 May 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePW7vO3w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24E226534;
	Fri, 23 May 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991530; cv=fail; b=F3NuC+U1DxFjHKI4/CtVxviZSZz3vA9fmRxbpMymN3k/C06A9ljrCWpysfUfsny2AN7wwEbafS939tvDptfGspchjxXi2Bd5PqSETlYy3on3QdLf0AEPbF7vdpSm0p8+Y7fVPo2PkzCsQWeqSAeOtcQtM3aJ3opBijkoH+WHJZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991530; c=relaxed/simple;
	bh=geKp7LZ6zIiiTdGhbwdNjP5AqNWxaVSNmv1qBn9wEJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifH/2BHEgD6rNEBXZQzoQdAjR/9Ub6bllR1KlHEfqP6BrlAQ5KhYiN9CW3e/y4lWa+OjTPyqPQnr1YSILE0miHoYtaEZ1Ut9jybnm/fK9MloCbA4ZDyd3t4fEShoe0kjEUqWHiemryuHy3Wvxg3qJth+way80S5c8Gyaj+yuoFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePW7vO3w; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrG6xuX2SKWyLMMMyc06+AlKwxPnf/Hj7mXrLndtVya0DRzTWOVWNYRMdf2lmFndsv0NCnVv18ELKZ+kVhGv4YNCb/hoAdRv+UTmWGJgWqcUFqJycLEbSTfiQwYBTmMswR0gD25uwjDSh7oL3Y1wkSHfw4bbEm9SODWfMbhxNoYe6nNSP4WnBy1jdiapyN1gOYkKE7WjKu8p9yVcwgER74frJu13bJB1a3Bcs+9eM8E24vg2rPhLoq34RymZPg+ODvyWVONPxDXjQYdRT530wXIASsXbxoWlmiVCSFH30GiGjrKBbtknaMEc9xIKHbCGoVw46M64+VZ+SkdMLzaFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgH9A0OUtkkGEYo3vxXlnrsFeyGgbMg8rsqCA5d7SCw=;
 b=AR/IRUzIxskGOulg1s2QxVcfmdAhBT25K9aFFVhjxQTHkzqY+wFCD4dwz3wFroCb1CWXKjKycmYrqZuZW08KAeV/WehtnAUdK/yumQRklzGb+AdCNkLd+iEL/oUZKZU/OOYaDx+B+XkVeu4JHANF9h5Fw/9a51kk0p5QCYMUSTt6JAs+1BFZw0yYu7GIPQ2jzKuhLvujvmyg1zHcRnJkWGDQs9JF+Ziq3yfPmkQq+bbgzgsIrTf/4N03ZfUm65Jjd+NWDPJvOu4p+20+jE450Qu0xMbRlPg4t28y9UJ5ttPvSm9/Jw29sJFWlAwFXzkJF5FqM8vtO5ZPwZ/ojR5CEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgH9A0OUtkkGEYo3vxXlnrsFeyGgbMg8rsqCA5d7SCw=;
 b=ePW7vO3wXIbzPncF+cYmTxxJ6EwiNV6YHoELtV5TsmfHallX4xZnOotR1Bg7aLKa/OKU+NUcXDGswBK8UkOMz/VvEvuzo6bBkc2zOdqkxc/Ek6W7pPNGKbOiaPOSdq2oqa3k05GDHIKbamUZB3VDs+tePV1naGHQK2JGcpxiIYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 09:12:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 09:12:05 +0000
Message-ID: <e60307b8-f865-4e53-9ea6-13e198eae24d@amd.com>
Date: Fri, 23 May 2025 10:12:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
 <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
 <0636c174-4633-4018-bf52-f7f53a82f71a@amd.com>
 <682f8048a40a6_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682f8048a40a6_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: d84a9fe4-efdb-46f3-0d45-08dd99d9e30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFdYOGh0SmNhWWJWVkVhdGE4TWZ1eFNOVEFGL0JHQVpEbTBHQTRXcnJXbjlk?=
 =?utf-8?B?aEgrV0NFZHBFeS9wSlY3Yi8yYVg4NXNlVVZuWTZmZmFBR3FGc3ZSb2hMK3l4?=
 =?utf-8?B?d0M3Rm5ZdlVYS0FCS1hOS2FjNTA4Z0hQNWZzMklXaGtmNVljYnNDL2YydXFr?=
 =?utf-8?B?MEZDZVpwTUZHaWJNRDFOVU1SNHMxbUVVOU8rOXVkM3J1aU9wSHJTZDc1elYr?=
 =?utf-8?B?UDdJdVZwdHpaNFlPOHcyTEJFaG4wMTN5NlYvWHozakZ2ZjI3VytiZkxnSy9P?=
 =?utf-8?B?cjBIQlVYdHRZSXdqdkxPREJNWlpYZklCQjVYRmx2SlN4TEdENkg4MlptQXZN?=
 =?utf-8?B?WmhoQ3VFQmRjT2VGRHJhVXp5NngveGVlWm5PVUxNZTc0MVlqMk5UK0xpUFk2?=
 =?utf-8?B?QVVRU1NqbDlmSkU2Uys3dmlkclNJdUcxbCtLTTQzWjVlTzNCa0p5MDBhYjhR?=
 =?utf-8?B?YVNhVWpOaC9WVVJtSDREQkx2U2J5S3d1c29Dc09mR00xMHBGMFBEVGJTSUs3?=
 =?utf-8?B?RGJ0LzZSTEVNazV6TmpQZ0hta1FJV283OFE5bmltcE5FUnhYb3VzMWZYeVhQ?=
 =?utf-8?B?Sy9pK2xGQTIrLzBFekFLdm1Xa3FQa1IvMFl0b2xLVW9kM0ZxdDhkU2RVU3hu?=
 =?utf-8?B?UlpSNzBzWFEzczhNV0NGVDlmb1QyVEFJRU9maDFrdTBrSExPd0FHSXJCT0pz?=
 =?utf-8?B?Ump0VE1xTThyOGtOT3VodU9uNlZkZXFKRGZpYmMxL1o3U2RUemFkWWFBRGV3?=
 =?utf-8?B?enh4U3I1cEZQM25sUC9CVUJFalJBNzZQSDRkS2ZocFI0ck5KYVNIVDhCRDV6?=
 =?utf-8?B?SWlLd3Iya1R0TGRpSmhMTHU1UldwdkNSOUU0UVFkYVlobjVJNXkzZ2IyOXVS?=
 =?utf-8?B?MmJwK1J0aGtwNGlRQS81aUEvb1NzM1RYSWJxT2NrZ1JIWVJNOEErTk92dFFj?=
 =?utf-8?B?UlZWa1I3UnBxRlRtUlA3YXJvQzFPaUdvZ1NPN1I1cHNEaWJSdzMzNDJZcTRv?=
 =?utf-8?B?ZnJHaXhRQjlVNDBLdjlTSDFZdGp3VGxxTTlZZnlXMnlVUkJub3ljMzVabzBq?=
 =?utf-8?B?aHpKeEVPZDllSm50RVRmNHdGRVM3SkI4d1E0a0txdUZSWksxWm5YbWtMOXQw?=
 =?utf-8?B?RG5ycEkvWGNOeUZMaFRqT2dMSUYyQUtKUk9XQkIrSFdHYkRkTk41Mmw2WERo?=
 =?utf-8?B?ajlWeGkydGh3bFlJcTRSc1YxQ3N5OXRBTzdyZFVEQkJHT2ROYUtQRTVWSEJs?=
 =?utf-8?B?YmhpR0JiSlRCdXp3c1dIbk9vOXA4Z01ia2xaOUNCaytXVjMxRlJKYlJIT0F4?=
 =?utf-8?B?MFVSY3NGbjdTZFk2QVhLbkhjS1FvM1o3RFcxcFR3N0pkVE9TKzhmUUxzOFJ0?=
 =?utf-8?B?M0JpVmI3WThkK1lzQjdQSlJBTjNJZjFMZzNEbXp2VFRveTNNb1FYWTd3YUpT?=
 =?utf-8?B?RVhvNHY3U1RUTGtUcGN0QS9sSHBLOEtUOUVLcWgwTDZYc0VMdTNUNW9JTVJw?=
 =?utf-8?B?QkdXMXB3QVBvM0w3RUxEc0lvQkRJa1RVYzFUWXBIWm5HWGJXR2o2U3dueGpO?=
 =?utf-8?B?Ui9zclRETkZ4eSsxOEg0TWVkNXdhTEk1NGdLaHptNyt6WGRieGRXNkl6NUoy?=
 =?utf-8?B?WkdDNDNZcnJEaHhsWi9IOWp3R21qeG9sSVdCcnNxcXFYYVlMSkR0ekNVMTZP?=
 =?utf-8?B?aExrbU9rSldRMVRjanBjRWFwY1c2dGNWbnFRVVZVQ3R1ZEM2TGlnb3JyekQ1?=
 =?utf-8?B?bUkvSkl0ZGRHa2FVS0NCK1k5aDlBdjJZRFNQY0RaK25vNXRhTzhvdG95eTBO?=
 =?utf-8?B?TmNtc3IwWDNaU0NRNzl1dnowVTdVclNSaWF5cEFQVXdqcUIxUjdLYThob0hm?=
 =?utf-8?B?ZGRLY1REclNLTy9hVVpMUllyeW5ZdnFkNXVjeXpXYTRPRFc0bFdLdjNTOGh0?=
 =?utf-8?B?eCtybXVFRFVOWFpFVGM1TDZlbGh4SHkwa2xDOWd4eEtKNkJOTitscHRVSm1F?=
 =?utf-8?B?dTBITUZkZXhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWR5MXhYUW1obTZUUlpvWm9VMVdveUFkVXkzYWlPeHpTdmxkMnR3VCtReEpM?=
 =?utf-8?B?NG1RMUZhMDdVakhwemExbEZFRnBTWmdYRXlVdHRWU1ZIRjJoZEdTUWdBaFdN?=
 =?utf-8?B?Y0g5a0Nsdnd3SlRINU1FaVIzVzllNjJWQzBGMmVHdmwwOFNlYjVWb0c4ekJn?=
 =?utf-8?B?aFJYVlJJUnRHNVYvUi9jWWY4c080bnNOQ1ZmMms3RkIrS0NyUXdqai9RUFg3?=
 =?utf-8?B?ZzZ6bXEvTmRSTGJBSEhmZXdjaHZlcm5rVjdxNFBWcFlNRmNpQ2NLUTAzcnl0?=
 =?utf-8?B?SVcwN0N0dmQwbHNEWnRDYWMwQm5ONi9qSEI3TmVwNnNvaTdpVytteXFPbm92?=
 =?utf-8?B?NlUxaDVodGVqd2drZHA3UVVmbWZ0ZmpSaGxaNnlwb1Fqbkkzd1praXB3aGVM?=
 =?utf-8?B?bWUwNzIxa2dmK1dnQlYxdmZiVi9kS3E5Z2lWcVMzajF6ZmVBMmFCaHRDQ1p6?=
 =?utf-8?B?azVzRmlLOEtFR3pKWHkzWC9rYmFEMFpBc05mdGZZYnhEN09XOHpkUVhHekRO?=
 =?utf-8?B?UUJwdmJ5SXNVZ2FyaTVIMGRSVXczaFpsNUhvWVhkMzdDQW9tTUxLYWlLZ0lF?=
 =?utf-8?B?OE5JNEdTdUFVUHA5M2ZvR0laR3Y1RTFTbnplcEdJK1daNEI2bytRYlNoeDBN?=
 =?utf-8?B?elRBbkc2OW1wQWQ1Yk5YVjV4K0F0OW1yN2kveFJ0S0IxQkp4M0JFdW1tbjkx?=
 =?utf-8?B?TW9MS0w4UXM0MlJFcUpJVmNBbWVvcngyMGxLc1g4VWNSZFE5MjF6Qm42Qmgw?=
 =?utf-8?B?ME9mZk12U0cwWW1CbXhCWS83T0kvTURXY0Y0YmFaZzg2OGRnL0wzVkF5NTQz?=
 =?utf-8?B?N2UzLzhZT0tJa1VLZndaVmh4RmRGN1ErV2l0YzRUVzhtUzJpTEJmMDNNUDNF?=
 =?utf-8?B?S0M5ZFZhRThLYjBMTTlKaVRFb09Bcm9WNHVDb3U5eDh5TGxQWXpYclpQejcv?=
 =?utf-8?B?WTJyVTFaNVJ4NFVCNDY1OCtuUXNWdWgvalgzSGt0Y3RoNnYvbGtkRlh1dXVG?=
 =?utf-8?B?bzAzLzcvYytxR3NLRHVjcHNBQ0VpKytFTlkvTEZVQnMvT1RzN0tpbTdGczdQ?=
 =?utf-8?B?SjFLVU1HYm1rSHFETTZuanpOM0UyS05CNGdJbXZjdWp6ZXFUZWpaekc2dTFP?=
 =?utf-8?B?UGxsT1lwS2czY0I2a09BYktVU0RNZGV5KzNKK2xSQ2NBV0Q3d1VmZUM4ajlV?=
 =?utf-8?B?RjYvUE9Ebm5xd0ZsNTBWSWNQQmU4Si9jWkNBR0g1ZW4vK1pwZnpYYmNSUTNx?=
 =?utf-8?B?Q3R6U0xtb1pEejhvbUg1aTFDYk0wRFZTVmJlRlQ3NmlDUEdaQ0thMCs3ZFVX?=
 =?utf-8?B?Q0kzSjZRbDUrSHRhQXlkK0pYbWg4Y3JkaU5wSHhrSDZjR3E0TjBpNVo3a01y?=
 =?utf-8?B?K0tGMWthaFNEZnF4MmM2OWVOWDZQKzU5djdaSzB0bitsR1hvVmZSdzJsTHYx?=
 =?utf-8?B?RkVsRkhQRXYrVmNvSUxGMEtpM0t5VUhXSXpHaUY5QVRWc05xWDc0MlJ4WnJ4?=
 =?utf-8?B?L2FHYU1EVlBpQ1RlTStITFRLRnJpM2ExMXltUlVDMERRb1NZS0QyYzBqNUFk?=
 =?utf-8?B?NlgxbmFPTzdmZjhGY0JkZ21Ra0ROUzQ0U25DNDNjcXFGNnNzTE9ETE1sbHow?=
 =?utf-8?B?SlNkZVpNbkJDaVJCZWpFVGwyZzdTOW9MeFRUQlZXQk9iditVVElTWUVIVHdC?=
 =?utf-8?B?Sk11V29VT3Q3SzkrNTZWbGNPaWRrZzJRR0o0SUgzMGpQRXJqbjBVNCtyZG4z?=
 =?utf-8?B?YU9KSGFwL0piSXQ2QzBieHhZNmZ6S2htNHV6cEl2TEI0b2JKWnBnaldHeWtV?=
 =?utf-8?B?SG9mS0xmUEY0cndSNjJLU05uTGpxMU9YbGQyUFQ4YUNGT0piakR0MEh1Mm9p?=
 =?utf-8?B?dC9icjdieEt3aXFmeC80L1RUSEt3MldZeDlPRTRVS1k0UUJzWmhKM0kzTzV6?=
 =?utf-8?B?aFdMV0FWOGdDb0RoMnV3blhhbFlFdnEyd3AwTGZlbkJKZnlSeU1HY0orL1M5?=
 =?utf-8?B?SXBxMmoxWndieW1xL0pnalpjT2ppYWd5bmpQVmgzdG9mRS9uaklibGJLUUpu?=
 =?utf-8?B?amVCM044QkcvS1JET2lTU0d6UWV2K0ZMRjd5eXoxdlo2dHpzWVYwdzl4RE1U?=
 =?utf-8?Q?DwozXJLKTXuk8pqVQxK4g+kCg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84a9fe4-efdb-46f3-0d45-08dd99d9e30c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 09:12:05.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23wVP9U3N+rm2USEzf7QixV4og5LslSwWrAHodBQUENLtfcMgIm9srIdkWA/LZXLCvLUR3L9+3GZ8TEurwbgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796


On 5/22/25 20:51, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>> You did not like to add a new capability field to current structs
>> because the information needed was already there in the map. I think it
>> was a fair comment, so the caps, a variable the caller gives, is set
>> during the discovery without any internal struct added.
> The objection was not limited to data structure changes, it also
> includes sprinkling an @caps argument throughout the stack for an
> as yet to be determined benefit.
>
>> Regarding what you suggest below, I have to disagree. This change was
>> introduced for dealing with a driver using CXL, that is a Type2 or
>> future Type1 driver. IMO, most of the innerworkings should be hidden to
>> those clients and therefore working with the map struct is far from
>> ideal, and it is not currently accessible from those drivers.
> Checking a couple validity flags in a now public (in include/cxl/pci.h)
> data-structure is far from ideal?
>
>> With these new drivers the core does not know what should be there, so
>> the check is delayed and left to the driver.
> Correct, left to the driver to read from an existing mechanism.
>
>> IMO, from a Type2/Type1 driver perspective, it is better to deal with
>> caps expected/found than being aware of those internal CXL register
>> discovery and maps.
> Not if a maintainer of the CXL register discovery and maps remains
> unconvinced to merge a parallel redundant mechanism to achieve the exact
> same goal.


OK. You are the maintainer and you'll get what you want. I'm not going 
to fight this if none else back me up.


Because you refer to your maintainer position, let me just say, in a 
critical but constructive way, I'm a bit pissed off with this.


It is not because we disagree nor because you as the maintainer have a 
weight on this I don't. I accept that and I am also happy to discuss all 
this with you even if I end up doing the things your way. I'm pissed off 
because you have been silent during months, with other people in the CXL 
kernel community reviewing the patches, commenting and raising concerns. 
I think it is discouraging that you, as the maintainer, allow me and 
these people involved in those reviews, going through a path you 
disagree with and say nothing. Again, it is not because you have another 
view, surely more relevant than those less used to the code involved, 
but because you disappear for so long.


I need some days off now, what is well-aligned with a four-day long 
weekend for me, but I'll be back with new energy next week for 
addressing all those concerns.


Thank you


