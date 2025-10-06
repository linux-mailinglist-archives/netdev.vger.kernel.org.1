Return-Path: <netdev+bounces-227913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66260BBD311
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 09:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA283B2206
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 07:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08605254B1F;
	Mon,  6 Oct 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="INugMzhP"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1022D4DC;
	Mon,  6 Oct 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759734776; cv=fail; b=X/ix7FOhXI/oOA5UnqTV3DP9vS/6zxatVopvgx1ZgJxf7iMxxd949QvpicbI2HnWt9w/raR4rjaml5hEXgKFnN5hmp96b9zyzbWmgRnLzUd7VED75R2B17XWaxOj6AjWe3RvERUJ7Oa1pZey28TYWvszwehSJydtL3wsmKOtM74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759734776; c=relaxed/simple;
	bh=CJVnfQX7RRjYFuZO3Bm3mwlbWLEEHs944qJL5aNAf4s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADP6/lRuVUyybr4h/FA0nqLhL7rI8D/00wjWLU+/xiIp9k4w6JLOzZf0lsaDNLaOuRJ/mQOfwwBLaxSdNMKbqLk9pBAADu/0Q1iHssIyDBbcPAPvJWyumt+r5h0MCKvkgPRrt1bGQE+ZceXJSYcCpE0Vnf+sCptecxAgrXRpMbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=INugMzhP; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAJTq+sIqmecaKkD7JS4gl74KsRsc2IAC9qozwc8DV+jph+X4yNmb6xu0V0+7IMgOM8vjRFsobAc5tzXH49CBxWhYIZfi2IMbK6A5plet58b/HN9Su9320wNZNbyN9v7weE02cs4wmu7ugob6eJFur+mTv0ZehFtmlVHNpfLJTT9SUMu3GQCErrsAfob2X1rsXrs9KEgDPqLSAdg1tNOOb30nDrUcPnDGDOnshqhD0bni+4VF+m8I6LfHsFqJH+/CLKXunAErekhxcD2p/zJmmiE6GFUTaoSUAeJ+meF9c82SqoGMOXmtnYUu4K/Xm2cQN5ursdyzEmlHbR+4r3neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdeWM9nbqQdYuuQPE6WEvv+qPkEYcZ8Mazu1tBr+nMA=;
 b=uvn89rsx48DtlPsD4vyZZrjZYyXeJs8cpsDRMzwIHZ80nZksn8QmwiUOzKmkKm0wyafJe1kJQZ+rIARyXwcZZunJvYbZfNLRcdd8WYY5xO3+75zbTilqYGVkbqJJh6d3Jk19yKMid+oMUd7W1UynSuhx9mFW/Hfmt15pPagW3iXoPj5uMRTCcC0vif89U6kb7h3L8s1sZaXCa/Vw44RbX0ikAhrltn6Wm+eKrqEWQmB73+yWlPGMie67mHn324GLZ+KSzgyzhUeQAZ+gCFsBNCM//gApNYUcZkq+3xBWrxKD21lhgKP6Fa3jeHUMc/H2+Vf53nRHvkhidHIBHuHrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdeWM9nbqQdYuuQPE6WEvv+qPkEYcZ8Mazu1tBr+nMA=;
 b=INugMzhPNedrwlbMD4f2uhgYoWXILd5TYf3Gh50Z8M5qSkD9ddU4erujNC4+RM87nkTAZTGABIcEu7BcHxhB0ZY3WQzTkziYnCmmgdUDjJ6d/yFh0j2KFShtOWfHEgIEockdEUhxtpt9mvaz1P76smvWcKNu/bI0t5F1C+rnULc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 07:12:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 07:12:47 +0000
Message-ID: <1d6631f0-0633-4e46-b318-e579f37a1ae7@amd.com>
Date: Mon, 6 Oct 2025 08:12:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
 <a3138cd0-455c-4247-be4e-c8f4f2c71e33@intel.com>
 <1f0e2207-8d99-4eb8-880b-8ba859f8e86a@amd.com>
 <df18f0bb-0939-492a-8c5e-bc9e35260535@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <df18f0bb-0939-492a-8c5e-bc9e35260535@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:10:232::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 641520cd-1ca6-4010-7376-08de04a7c0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVliN2lWd2tZWUNXZFQvTjdDS1NFaFFiaGpsT01jc0RMM3pMNDRJTlFrK2Fv?=
 =?utf-8?B?N0hVVXNDd3pnNVFVcU1qZFVRb0t4MFRWQnhQbDg4MGZGS1FiRGF1VzlZWXJL?=
 =?utf-8?B?NzFFc1JzWDhpZ2NBa2Zqdi9yTm1XRjNnbTVTWExWZ3Y0djhXTGZ2MGp4RTMz?=
 =?utf-8?B?SWF1WU9EbUkrM001QTRvRkZDTENFZDdic1NBTXpQT3N6RlFoTncrSVUyRnBJ?=
 =?utf-8?B?NzdtRStjOXBUMzNkcVZpd1pmOXBqQXg2Y2k5bFYxQWRtczMxN3BucGlKZHk1?=
 =?utf-8?B?VndwY0YyYTFHa3J6WlNIbG0yaXZtRHh5MnI2ZTNoaWZEV1JMNWZ0VFl4Y3lu?=
 =?utf-8?B?RWVaQ1BZZFZIUlg2S1dKQUJwWmJsNFRTYitTdWNVNWJkYjE1MWw0dTJwSzJL?=
 =?utf-8?B?RW42QTJjbWhYRW1PWkFaTUFPazBHK25kUWVWOVdoS0xybHhHeTI2ZVRpMFFy?=
 =?utf-8?B?UXBGWE5xZ0c5MEhicXpRb0hHeHd4UThrV0JCMCsyQ0lLbXBhUVFjTUhMaSt2?=
 =?utf-8?B?QkhSdW43Z3gvbGk2ZEN5UVFYTUFtNFROM2hqZTV2NHpsQnZvYXF0WGEyMkRt?=
 =?utf-8?B?aG9qS24xbjlFNzNjQnlDYlRnaXlEMXMvVmNnS0ZzQXZJZXlMeHVyeGpaTzZp?=
 =?utf-8?B?Sk0zVzRSa0VneDg5YWwwZFR4UmE5QnluWWxJa0tPMExDVDM2SlFxQTYxaUFx?=
 =?utf-8?B?SlZlYXRhQnZid1hRZFNoZW1SZmJQWlE4R29FVVR1eFdYK0k1VG96citVUjlL?=
 =?utf-8?B?M0dKUkJVQ1ZkalptejFOaFp3QmVLM3l4OHAyNzB3WVhkdVRPRHRWZnoyTFhZ?=
 =?utf-8?B?V055UEZSSlBhUGUrL21Ib0k1cHQ1ZkNLbG9kbUlmZ3pONlVGQ1dlMEVUYjJ4?=
 =?utf-8?B?eE9BZTVYZmNSS1RNWkF2Si9ibHFKZGJOcU9ScFVPWWpJbzEwSkJLckhBeU5M?=
 =?utf-8?B?MjNZL0lRelE4ekJDMmRzNDVnbW50VDhvUS9kZ0VOZVNJVjJ0UGdQaCtxWkhi?=
 =?utf-8?B?WmNIVHZ1eUJmdDRYazlyMjk2ODY4c2IwWTc3cXJ2aXRwTmg1cTdKaUIrbFVo?=
 =?utf-8?B?N0JXY0lwM1dSdU5XNmd5cml2UFdhLzM4Rmw2bWtBMGJrNW1DWlBxZnJidWVY?=
 =?utf-8?B?ek8zemxucHM4MjNSZzNZMnVHN3NRZUFqdE9MQkJ5dytmTjYrSGhHaGFQQjls?=
 =?utf-8?B?a1AvYitIVnBpUjVURGdCUkJwWmpSSlNVSkh6T2Q0dkl2Qy9xcFdnTVhIMFIz?=
 =?utf-8?B?REZBazV0ZGo0NmpLL2s2R0dmV2VIdm1GUWo1MnpkTHB6M2oxTDBNTWY1ZEN3?=
 =?utf-8?B?V2dwR0JUaFBJanRFRTlLaklBdWs5ZjQ2aFhvZnpzVmxES2xpYVZxYTJuOWZi?=
 =?utf-8?B?MUFlZFlKcTJ0T2N2SmEvQ3phNUpsTWRXVUxyWVp0OHNIMzZ0VlJERkRpcmhh?=
 =?utf-8?B?OXBHTzlOWGRsWTFGNjZSSXRoUXp1WHNiQjJYVG4wWGtYZkdEOTRYSEROanU0?=
 =?utf-8?B?OFlGTEZpUXhoTkN3Zk5NUy84TmNGVnQvQVVHeCswMk1IWnpMMi9HWHh3SFNk?=
 =?utf-8?B?WkNnQkpTSnBtdVNwYXczY3NZRjhwczhWbUpUd1ZRdFhuM21yWXQ2cjlzTmN0?=
 =?utf-8?B?RENlSUZBUmFHdmI4a2g0QTQwN3dBT1F1aFRMVWpJQjl1dUZNU2VobnlRWjNi?=
 =?utf-8?B?R2VNUzV2Q3pUVzZzWG1GQXNmbFZSNEFqNE5ISGtYMGxuS3pBNkI4ZGVSNk9E?=
 =?utf-8?B?UFV1Y3FHamZvTUdVVDJWUVNRTWZFUHQxT2FLek1VRDZrWUNhbkNlNjJUbHVy?=
 =?utf-8?B?UG92YW8vZlJzMDNVcnVOSG9TbDFwb09aVkc5V2hlWUIwRjhFKzl6cTZsbUFi?=
 =?utf-8?B?VTdxbUJRZWZWQXdTWWpBdTBleXVCaXFxbEMyQnowTVBVU0dGT3c5bGJlZllG?=
 =?utf-8?B?Q2VTelk1NFllcWQzM3FCY0xYOWF5dnB1cVFtdmU2VzFCNGgyV0prL2pTeHE4?=
 =?utf-8?B?RmhqYUQ3VWRDYVlONWgwN05CL3hyUzFvMm1CLzBSd05qcHRzSmZPRm9TQVJP?=
 =?utf-8?Q?t7oSUz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lyt2MElGUnpxNkZNSWpxQ21CL3pSMHMwbWJNVFliSTNnOWcveHp6U05TcWdi?=
 =?utf-8?B?Y01LcmcrZVJBcXpVYncyYzZ6b0IrTDIxRnd1MzQ5NHJUWXdhZGtBYUpHcjJr?=
 =?utf-8?B?cXJ5eUVtUVdva0lKNEtyNWE1Y1htTG9EUkpGYWNuOCtaRjN4QkE2TFdIZ3p1?=
 =?utf-8?B?WXR6dERLYU9WRXNXdk5oQklSVmt5V2VWUFphK3N3eXlxUjBUOEk3S1FoZXZG?=
 =?utf-8?B?SE9yZTlLSFVxZmJpV0oxcThxaDJGSVcvUTZVa3pYSEthM2ZKL2lJTkhLN0Rl?=
 =?utf-8?B?R1UrakxBYWI0R2NDU3dWOHdlcmFoRmZjbWJEbFBqNDJ2eExtV2hML2RXN29r?=
 =?utf-8?B?eVhyUkdGeCtFdVpIY2IrTEluOGxGSDBTSEQrOXlkT2tCQXRPVXIwcENYSis1?=
 =?utf-8?B?ZnBLWlEwMjFHYzFtU0p0L3I4MExxY0xBR2IrdHBqUjVtdnJqU1ZLQjhoaXNo?=
 =?utf-8?B?Y2VJZlZlYjZOckRJblR2U0d4c2RqSmQwVHVCSXhvM0JJdk5LdUNsUUVMbnNz?=
 =?utf-8?B?NlZXM0Q5Vy9QdFVxekk0N1VkcFhSZHpqUFJMRThFUUcrNk9BTnlvVU1mTFlF?=
 =?utf-8?B?RW5LVFdSQ1g3TUVXNjlYS1ZrbkRpYUdaUTBlcCttRzIrb1FXUzdBZEJrMzdH?=
 =?utf-8?B?bHRKZTNXWVArc2FZZ0tPamhuRmVoSUIwc1hJclBNSHluM3U0Q2JCWU9NczVL?=
 =?utf-8?B?RDQxSkVkdjFzb2VzK29ZL1F5MWMwSkF0T3RVMXNBSTVyajFod2dwR2VFNVRy?=
 =?utf-8?B?SWVsUVo1SWhMbVExMHV0K0tUcDdGRjJOZXRqKzJsYmM1Yi85SmJydXNWQ1ZW?=
 =?utf-8?B?NWFwSmQ4QVV6NHcwRVcyajlxbGczam5VMjVTNWFKcHEyTitzOHp5aU0rWTZa?=
 =?utf-8?B?S1l3UEN1WGFvM3VoREVGOTVvRGJjYk0vbXhBMm9OWit5dlZXcnNkRlEydERL?=
 =?utf-8?B?SnlCMEQ0SHVJVWxsOGo4N1RMTy9kL3ZiQ3FrdmJPVVRqK3B3cXRXelBDMkYx?=
 =?utf-8?B?ejlDQUVhQit6VnRqYitYUWdWMFR6VHluSDBUdjFxaWRrMkZKcWkySFVESzVv?=
 =?utf-8?B?UVViNS8yL3ZjVG1veFZabkRQc0h1Q2ZsajNQUFZWMUV2NjRyVmIzc0IwejZw?=
 =?utf-8?B?RHFhTTc0ZG1vaVB4VGdLY1pESUNxRE9rOUQrNnR4OXREYVFlU2h4YlliaG5S?=
 =?utf-8?B?a1ZrRHZJOEVoeFdMN0R3anBvZjdWRksycWFERzRxTEVXUFM2ekRlSUoxbVg2?=
 =?utf-8?B?NzNwamw4QnJOTGlTUUdSVEJITGdTWGFEMnRrK0hhQitqN0pBRWRldUVIV28w?=
 =?utf-8?B?ZVh6bERWK25lams1VkkraFBmUXhTTlZJUmpxS3FzWkE3aHlsZlZPNDNGdmYv?=
 =?utf-8?B?a2F1cmIwNXBxUDhvVzFXTjNkNWlwUWcwalpOYWw5ZzlpM3hiam5GZkdEQWJ2?=
 =?utf-8?B?VkZXdmFkZ3grUlRiTEhUMVRobUVBaUtHcmlmV1lPNHV0aUlydWtEREZtbVNK?=
 =?utf-8?B?R2R6YmZtckZqa05ZbFlCTWFsS0RLUUNKblFvNC9KWWVYRnB1WlBqaEZxNERj?=
 =?utf-8?B?RGlzZUJaOGRLazdYVXZFRnhPTUx5Ri96Y3ZTcG1jQ1VoaVVTSkJ1R0ZJOHhS?=
 =?utf-8?B?dVYvY0svMHhmSkoyM1dWNjVwVW5veEd1MW9wcTVpNkUva3FTc1VkZzRJeW5h?=
 =?utf-8?B?clBQd2grbEdHNjRGQ2hDYUlCbWpaQnJUVXN6S3dlMXpiWkxIU0puMTVDd0NU?=
 =?utf-8?B?dFE4UjNlRE94dk1jUHQxWnpiakxRdHEyTG82L2ZmdUoxOU0vNzRHTEZBWjV2?=
 =?utf-8?B?S2g1RXdZWlFmUFhYRWVUWStjTHA1L3JRWVFnUUxPUUNPU3M0aExucytWMFBO?=
 =?utf-8?B?Z29mMmV4eU41MGRzZWREL1lTNGc0VEFXUHJQV2tmUDI4WEZ3bHZYVmlna3B3?=
 =?utf-8?B?Ti90YU9nQkRiZkQvTlk2UU0rYVB2T1NXdjBrd0t1a3BiSHBlUG1FdFJyZEJJ?=
 =?utf-8?B?TW15UkVJZDh6VWhKazBWM2VPNVNJbGErdGtCWVc1OWFsNnV0SWUranczWnhX?=
 =?utf-8?B?SWpuQVRkcFlUWlp0Z2Fzb1BGWFRyY3lVRC90VkZ3Z1cvQ0dtanpUQjhhL2hl?=
 =?utf-8?Q?LemqlhJn8qLFCBQQE44ay3jfu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641520cd-1ca6-4010-7376-08de04a7c0d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 07:12:47.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBIi+d912AY4E0oEbpe6SM0OW5Tch2Hk0D8sQG8Nq+UyIecQ76hp5HJdgINF4FcBgdAlxaMQk6kJAHrLSoGLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074


On 9/30/25 01:52, Dave Jiang wrote:
>
> On 9/26/25 1:59 AM, Alejandro Lucero Palau wrote:
>> On 9/19/25 21:59, Dave Jiang wrote:
>>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Creating a CXL region requires userspace intervention through the cxl
>>>> sysfs files. Type2 support should allow accelerator drivers to create
>>>> such cxl region from kernel code.
>>>>
>>>> Adding that functionality and integrating it with current support for
>>>> memory expanders.
>>>>
>>>> Support an action by the type2 driver to be linked to the created region
>>>> for unwinding the resources allocated properly.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++--
>>>>    drivers/cxl/port.c        |   5 +-
>>>>    include/cxl/cxl.h         |   4 +
>>>>    3 files changed, 154 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 7b05e41e8fad..20bd0c82806c 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -2379,6 +2379,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>>>>        }
>>>>        return 0;
>>>>    }
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>>>>      static int __attach_target(struct cxl_region *cxlr,
>>>>                   struct cxl_endpoint_decoder *cxled, int pos,
>>>> @@ -2864,6 +2865,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>>>        return to_cxl_region(region_dev);
>>>>    }
>>>>    +static void drop_region(struct cxl_region *cxlr)
>>>> +{
>>>> +    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>> +
>>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>>> +}
>>>> +
>>>>    static ssize_t delete_region_store(struct device *dev,
>>>>                       struct device_attribute *attr,
>>>>                       const char *buf, size_t len)
>>>> @@ -3592,14 +3601,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>>>        return 0;
>>>>    }
>>>>    -/* Establish an empty region covering the given HPA range */
>>>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>> -                       struct cxl_endpoint_decoder *cxled)
>>>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>>>> +                         struct cxl_endpoint_decoder *cxled)
>>>>    {
>>>>        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>>> -    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>>        struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>>> -    int rc, part = READ_ONCE(cxled->part);
>>>> +    int part = READ_ONCE(cxled->part);
>>>>        struct cxl_region *cxlr;
>>>>          do {
>>>> @@ -3608,13 +3615,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>                           cxled->cxld.target_type);
>>>>        } while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>>>    -    if (IS_ERR(cxlr)) {
>>>> +    if (IS_ERR(cxlr))
>>>>            dev_err(cxlmd->dev.parent,
>>>>                "%s:%s: %s failed assign region: %ld\n",
>>>>                dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>>                __func__, PTR_ERR(cxlr));
>>>> -        return cxlr;
>>>> -    }
>>>> +
>>>> +    return cxlr;
>>>> +}
>>>> +
>>>> +/* Establish an empty region covering the given HPA range */
>>>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>> +                       struct cxl_endpoint_decoder *cxled)
>>>> +{
>>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>> +    struct cxl_region *cxlr;
>>>> +    int rc;
>>>> +
>>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>>>          rc = __construct_region(cxlr, cxlrd, cxled);
>>>>        if (rc) {
>>>> @@ -3625,6 +3643,126 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>        return cxlr;
>>>>    }
>>>>    +static struct cxl_region *
>>>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>>>> +               struct cxl_endpoint_decoder **cxled, int ways)
>>>> +{
>>>> +    struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>>>> +    struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>>> +    struct cxl_region_params *p;
>>>> +    resource_size_t size = 0;
>>>> +    struct cxl_region *cxlr;
>>>> +    int rc, i;
>>>> +
>>>> +    cxlr = construct_region_begin(cxlrd, cxled[0]);
>>>> +    if (IS_ERR(cxlr))
>>>> +        return cxlr;
>>>> +
>>>> +    guard(rwsem_write)(&cxl_rwsem.region);
>>>> +
>>>> +    /*
>>>> +     * Sanity check. This should not happen with an accel driver handling
>>>> +     * the region creation.
>>>> +     */
>>>> +    p = &cxlr->params;
>>>> +    if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>>> +        dev_err(cxlmd->dev.parent,
>>>> +            "%s:%s: %s  unexpected region state\n",
>>>> +            dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>>>> +            __func__);
>>>> +        rc = -EBUSY;
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    rc = set_interleave_ways(cxlr, ways);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>>> +        for (i = 0; i < ways; i++) {
>>>> +            if (!cxled[i]->dpa_res)
>>>> +                break;
>>>> +            size += resource_size(cxled[i]->dpa_res);
>>>> +        }
>>>> +    }
>>> Does the dpa read lock needs to be held from the first one to this one? Is there concern that the cxled may change during the time the lock is released and acquired again?
>>>
>>> DJ
>>
>> Not sure I understand the first question, but IMO, this is related to more complex setups than current Type2 expectations. I expect a single CXL Type2 device and without interleaving. This protection is needed for a cxl region backed by several CXL devices (interleaving) and where user space could try things in the middle of this setup.
> So it takes the dpa rwsem above, and then it takes the rwsem again later below. Should the rwsem be held instead of given up and acquired again?
>
> DJ


Hi Dave,


I think I can use just one locking here, so I will do so in v19.


Thank you


>>
>>>> +
>>>> +    if (i < ways)
>>>> +        goto err;
>>>> +
>>>> +    rc = alloc_hpa(cxlr, size);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>>>> +        for (i = 0; i < ways; i++) {
>>>> +            rc = cxl_region_attach(cxlr, cxled[i], 0);
>>>> +            if (rc)
>>>> +                goto err;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    rc = cxl_region_decode_commit(cxlr);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    p->state = CXL_CONFIG_COMMIT;
>>>> +
>>>> +    return cxlr;
>>>> +err:
>>>> +    drop_region(cxlr);
>>>> +    return ERR_PTR(rc);
>>>> +}
>>>> +
>>>> +/**
>>>> + * cxl_create_region - Establish a region given an endpoint decoder
>>>> + * @cxlrd: root decoder to allocate HPA
>>>> + * @cxled: endpoint decoder with reserved DPA capacity
>>>> + * @ways: interleave ways required
>>>> + * @action: driver function to be called on region removal
>>>> + * @data: pointer to data structure for the action execution
>>>> + *
>>>> + * Returns a fully formed region in the commit state and attached to the
>>>> + * cxl_region driver.
>>>> + */
>>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>> +                     struct cxl_endpoint_decoder **cxled,
>>>> +                     int ways, void (*action)(void *),
>>>> +                     void *data)
>>>> +{
>>>> +    struct cxl_region *cxlr;
>>>> +    int rc;
>>>> +
>>>> +    mutex_lock(&cxlrd->range_lock);
>>>> +    cxlr = __construct_new_region(cxlrd, cxled, ways);
>>>> +    mutex_unlock(&cxlrd->range_lock);
>>>> +    if (IS_ERR(cxlr))
>>>> +        return cxlr;
>>>> +
>>>> +    if (device_attach(&cxlr->dev) <= 0) {
>>>> +        dev_err(&cxlr->dev, "failed to create region\n");
>>>> +        drop_region(cxlr);
>>>> +        return ERR_PTR(-ENODEV);
>>>> +    }
>>>> +
>>>> +    if (action) {
>>>> +        rc = devm_add_action_or_reset(&cxlr->dev, action, data);
>>>> +        if (rc) {
>>>> +            drop_region(cxlr);
>>>> +            return ERR_PTR(rc);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return cxlr;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>>>> +
>>>>    static struct cxl_region *
>>>>    cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>>>>    {
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index 83f5a09839ab..e6c0bd0fc9f9 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c
>>>> @@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
>>>>    static int discover_region(struct device *dev, void *unused)
>>>>    {
>>>>        struct cxl_endpoint_decoder *cxled;
>>>> +    struct cxl_memdev *cxlmd;
>>>>        int rc;
>>>>          if (!is_endpoint_decoder(dev))
>>>> @@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
>>>>        if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>>>            return 0;
>>>>    -    if (cxled->state != CXL_DECODER_STATE_AUTO)
>>>> +    cxlmd = cxled_to_memdev(cxled);
>>>> +    if (cxled->state != CXL_DECODER_STATE_AUTO ||
>>>> +        cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>>>            return 0;
>>>>          /*
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 0a607710340d..dbacefff8d60 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -278,4 +278,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>>>                             enum cxl_partition_mode mode,
>>>>                             resource_size_t alloc);
>>>>    int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>> +                     struct cxl_endpoint_decoder **cxled,
>>>> +                     int ways, void (*action)(void *),
>>>> +                     void *data);
>>>>    #endif /* __CXL_CXL_H__ */

