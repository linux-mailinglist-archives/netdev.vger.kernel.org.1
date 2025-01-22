Return-Path: <netdev+bounces-160227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F13A18E87
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC3166D59
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BE21018D;
	Wed, 22 Jan 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0p0nFikm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4720FAA2;
	Wed, 22 Jan 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538905; cv=fail; b=HeCZWpcZQwpUZ90rpRe8pyuEKqlqsbhlq81Q9/rf1nqmASdwdBS5iId1uTs462lmn/13JcXVzSFVJjZ9g1I8su6kyB88WVR078asIEp2aGPn6Y29PeTHzJx8xhIGckmIAkR/7R0rvGng+i0mj9vOdQUEk1qL2j0qITq/g7e1Wlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538905; c=relaxed/simple;
	bh=aWdcPZzb4Z0+mn8cEsKmFCvnQkvEgHg6q/lsoa71lW0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6sP3J7CWK8+87p3aNRN5Gc2KXkUALxILGFFyuPsJakA81ctKp/DqbWK+aDlhdMmojAJkfAH1tfWtmhdBSlP5nPNadJmt0Nlz448oF/pYCeMG74QU2e2ErRnzHmji+2QsDs/pZpqrgD3puSekErt/Z2s4mMqCxhwFJLVNjh9sQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0p0nFikm; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZSHD+S+bHphUfKIApWkT6OwhaDCXt9127NwCOFUwrB2b2/EgG3lZpfQhqE0zyNDsSS8aJlc+iwNAXxQmrH1Ac/3UKMik0Wyvtg4frUVe7l3dH63W8TKF7fpyUn01l9MLs3DgQ/0G7KuQ5+aeyhG6mUixWNykTGBIC/vIWrvRAIyX83xnenR0Ws5CCIe8hfC5EKO0Wrxuth0WPSYctWvVgSuK67VUFmekzQvCNrrO0pl6DnGCE2bcnkGGrTNraxasq6mAED1oM6MvVTyh2fQQANDp9g6Hae3eoLegdSc5/TNSc1h2L9nFN4F0rR08R0saHCZsQ349CaDmztFDl6eIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZf9L2uV5LrP/pkkIcUu4KZs42mUeCO4dJZxPq8FgTY=;
 b=GworVLVbqeWHh1/0PkPO64hbBtVnAMcAvl+KtvgY4VtU08r7/3HCt6idUMh4YB84UXg6A1bsN/ZcfrxqY59YvroH1nx6SyMSG9QiVD3Pjl7+rkRvm8y8dmxRMO8AiM413nv5Ldsml0vcR9rXLV4nL+E0ibZ/MpiNpf5/hvw8BflxHvf57VAu4iJ+UfodTU9CtfNH3I+vDrx9tw05xccU+bgM2DTPdH36UV+Jo/8qvqHhpywnLvFPLfp7+4Ou/blO05vZtqvHLy6TJWHpq9zD/YxRKJQNBcWm5uz54VenWhzBL++zAR9KJx2fX7yOlARy/FPkyO7rEBVUicv9UvIyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZf9L2uV5LrP/pkkIcUu4KZs42mUeCO4dJZxPq8FgTY=;
 b=0p0nFikmK6Qmk2xf1ayh6ohbGtjIaoM4cii04WDoTZp8jtMkjrJnLUGi6M/YL6bYfK3r0Fidgb5Y6aH/gLNCWT6DDdV3KGvJFIJHwXaTzsQgCTP44kbDLmvetYn53eq1XW93ql6xlW8GYM0XYChOtNluRIBE63TPrZgMilbr38E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 09:41:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 09:41:40 +0000
Message-ID: <5180d24d-db23-e489-b27f-8575b78b5172@amd.com>
Date: Wed, 22 Jan 2025 09:41:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
 <67902761a4869_20fa294c6@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67902761a4869_20fa294c6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1723b7-f16c-4d58-aa98-08dd3ac8f91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWo0dWx3WTVTK1FCL0gzdkdFZUsrZWhzZFhQUUF2SXhTc3hwU0xDckNrcVpt?=
 =?utf-8?B?Z3NOTDFLbWVKL0grVmlMdTk2NWdNUG1MV1dwZEx4cUc2dkRONGpHeGZvVmR4?=
 =?utf-8?B?Q2FtYWxIcFZ2a2VXOFBURC9aQ25ETU9WWHk3ZHJ6TTZJTHh6M3ROVmZ4Vlpu?=
 =?utf-8?B?Rlp5SzBlYmZ4MWtpeGV2aEtseDkwcGZMT2xPT1R5enVKd1E1VHA4NmdDZU0x?=
 =?utf-8?B?VGdFYVAyeHVqdjl4MXNheWxpcXI2aG1PUHRUdWVGOU9kYWhZelVNWUZyeXZT?=
 =?utf-8?B?dVQ5NlpnYmtiRFpONk5lamZVbHh6UHNocVVFRkpZL21ORituMjJyUGpQM0lz?=
 =?utf-8?B?UTVVVjFITG13ZXNtTGpKWG43Z2tMTkhlZS9RclhxQy9YNlJGcGZ3eExsWkVN?=
 =?utf-8?B?ZWdvdmV3SU9pQ0ZUYVdwNTN0aWFpOUc4SGtPR013bjlyOVFUQWFmZ3JtUFlM?=
 =?utf-8?B?aTdMRnMzTUNrR3hwWGlraS9wR3YvYXdKbkRodWhaeGZpT1A0T1dmMUxEZjZx?=
 =?utf-8?B?Z0gvVGRZZ0R2M3JmSGdwSFAvdWtqbG9ocVZNU21Sb01wYXA1MGhlTDBrQTFD?=
 =?utf-8?B?ZXV3R1NDUzUzRGE3OHpmYUlHUjlOdFBTZVk4eVhJYjJVZm5TQWpNUiswbTZ2?=
 =?utf-8?B?Zk54ZVo1dVJ1dUdsZHNKaGpyMXhBcFBPRmM2KzFkMTNiSmFJRWE1VUw2WnVU?=
 =?utf-8?B?RGZacURGUkR2Q29mblVoaFRIa2t5clQ5NVZXS0VMQ2ZZS1g2ZlNxVEVpbkhX?=
 =?utf-8?B?WVRYZkcxTTVrR0FzZ0NMaGVNR2lINDQyVE1WL0NRUlQwdFRhVmlYbnpaUW5r?=
 =?utf-8?B?YlF3VlV2bitGZVdkZXE0Wmh2aHk4YWtnSytFZVVlbVV2RDZrazlNd3VwWlky?=
 =?utf-8?B?NllUODVNMnhSNWk0MEhzNGtyVzlPTERKdWg5VHg3cDJVQk52WmhhVlY1RnZ0?=
 =?utf-8?B?d1d6YTlKT2lseXBiNm91RWk1SEJndm1NZDZHaVowb1VXVEZVa05lclVudXV4?=
 =?utf-8?B?bWhROVlWNG9iZTZjZGRSdlY1NWEwa0Z3cFYyaGE2T0FmUTZMTVMraS9OSVBJ?=
 =?utf-8?B?UFZsQ1RGVm9NZEh0TUtqdGVKcndxMzQ5K2E0ZCsyWjRUWVNlZnk3ZFBkN2NJ?=
 =?utf-8?B?bjhOaGlsMU5EdFN0MVJBZExvNUJHdDZkbFZFd1dwS3NnaHhTV28veGxHenhC?=
 =?utf-8?B?L3FLdzU2ZXNMZkNsclBOWi93NHVwcUtQWWJVR2RiVEJNUklOR3ZCRjVFbmhz?=
 =?utf-8?B?NTZzWWVCd2Vwc28zTjczRWIvL0dCUkJCdFBOL05YQ3dRdmdTM1gzMk41TFZu?=
 =?utf-8?B?MUEzcG9rMk0vL04xbzluUEt1ZGtOUUdaRUdvekg4YitlaHdGUEhuZWp1YlJl?=
 =?utf-8?B?TVhod2pQbGlhTHcva2gydjVraGdKNm04M2NFSUJaZ1A5WFVHOEx3dXBuK2lR?=
 =?utf-8?B?SUltNHVIVFNjZ3loZVl4VGVsUHVRK1A1c24xcFo3V2c1SzNmcThGUDVmbHVX?=
 =?utf-8?B?ZnN4ZmcwNWhFMUQ3WG5yd2RncHR2a2UzMU9JY2VQSDBaUHc2amlrR2NXSWpR?=
 =?utf-8?B?Nm1hNHdxeG1aWjRkUFNXdmZ6ekE1aGhsa1lncGJjTnBzVnp0R2ZZbm9MWS9D?=
 =?utf-8?B?c3RpbDc1SWNtdjd5MzVhbEU0QUdqVjJYNTdjSCtqK3ZRYUtNQmY3c2grc0p6?=
 =?utf-8?B?UVFVWlVqRlNtT2EyQXpIbUtwOFhUK3JHV1M3TExDek1BRFA5MmxuaEJGV0JG?=
 =?utf-8?B?UVg1OXN3bTFKZE0rYm4vZEhPOFdEc2VZd3NPZnVsZ1FTOHYrRjFpdEtNcDB4?=
 =?utf-8?B?RmJOVExFejZacG1iNGZqUm5qUGc1TFhFVUp6dzlUa0lLdjJsMC9LdExqUGJT?=
 =?utf-8?B?VitKKy9zREF6TGdIMW5uREJmRjQxQnVLQmd3UktwQnRRMkFIVjRsQktmTmUw?=
 =?utf-8?Q?8s3GlHwhWFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpqaXZxSmF5SlpKL0VYSUR5RTBPYVcya2NzQ1VqeHU5R1dhZDV6RlgrMjU4?=
 =?utf-8?B?N2thN3pNNFY1T0pkeTZ0MUtxRWxYeHdtdkZwSm5wK3ptU0hFRWh5RzBtSGox?=
 =?utf-8?B?M3hIQ0FqZEpYenhXb0IvSTNCWWV2Rm9BOVRoNXNwbDdWRkM3MERpa1MydTFX?=
 =?utf-8?B?Rit1b1R6QlJsRlZpYVJ0eTZLL2RCcnhXWGhHU1ZMSmdJeTNSdXVMNXZIcTEr?=
 =?utf-8?B?c1JnR1ZhV3R5ejNYOW90TGVJSkRIUzJubjBsdDNUVlh0cUlKVzloS0k2cVdP?=
 =?utf-8?B?MVNCNmNnNjhLUFlnOVdRK1B6em1BM2lHcTlSakp5TURpWTFhaDA1dDY0c3JM?=
 =?utf-8?B?a0ZjOEFrNXZQNGc2SmVWMVV0VDFkT1NqSjNZL2xiUkRmb1FLL2N2Zzk5RlVS?=
 =?utf-8?B?anlKRG9WdEJqNWtlTGJUM3JiK2FMUXg4V1JSazRrRWVYVVJlYXNkRUhsaVBF?=
 =?utf-8?B?R2ZzbFNqcjR3SVlvMWt3ZjRPMzU2ZmhYN0JFRHErTmZ1MUREemkxMENtNUxO?=
 =?utf-8?B?N2xXdVkvTUZzZGxwRkNaUmlhdUR1YXV2RW1Yd1FrUEJWRGt5WTNTcjRlTFpm?=
 =?utf-8?B?Z2FwVWJxL3ZNVWNyR09SMHoxUVA0TW05ZTRpeTlDQjZLOUtTbXV5c0tET0Zs?=
 =?utf-8?B?Q3VmNU44Z2hQaUI4K0J3clp5UWlTUWpyaDA3bVByeTVYNktZOGNsRzk3WXA2?=
 =?utf-8?B?OTQ2cHJUV05LbWpwdGF3S0ozRXRHVlY1akE0empNSTBEWjF2bkFjNUxSWUg5?=
 =?utf-8?B?ZU8ybW5JRWE4YWYxZEl6Z1BxWEZ1aHpUZEZzd1NXZDE1SmlxS2ZtS1p0cUVo?=
 =?utf-8?B?UVJyWW9qaHJvYWcrR3BzQk5ud0k4MGhVaWd5VzgxV2RMNkxzdFZDbXl1Mmsx?=
 =?utf-8?B?d0JlMmZEMEtUWXVOZFV2Q0JWWFJaSS9FYUE5ellLa0tIbUZhaXpWdVZTVGZK?=
 =?utf-8?B?M0ZDZFlVbHNZTnBxY25XSkhOSEJ0ZEZHdGNSeDVWTzc5S21VbUlFZy8wUmFF?=
 =?utf-8?B?c0xIeWswNTEzMHVrY1g2QXFjY3lGb0Y2V0hMUTQ5ZVN2Wm1rTyszT0U0OTRK?=
 =?utf-8?B?OUFGVjY3cmh2cm5CUVVXWlFDV29oS0NubWFqenBjQWcyekxlNnFVcE1Jci9z?=
 =?utf-8?B?N1MxQjhPN0haMUhEQ3JHc1A5bXl6c25WWkkwdW9iQlpYTkpRenplU1ZXdTd6?=
 =?utf-8?B?SStQTittMVZKRmpaWFFZczdrTytmd0FpbDBmZkhwdktmQ2twbXFyUjJtOTBM?=
 =?utf-8?B?QmVkT0JkMHBsYyt4eWdsSWczZ1ArQWFaVm1aUSs0MldLWm9kRFRFZnYrdzF1?=
 =?utf-8?B?WTdibkpubktGaURDczFna1RCSGQxQlJsdHA1WGg4SHJ5Y05jbFV1TDhCT0I2?=
 =?utf-8?B?NnVLQnlHSWZJNWowMUc4VVFQVEczZnhBOTczRHJqQWl4eEJ6Skg0cGloYXBG?=
 =?utf-8?B?aHo5ZFVBcDZmTmlZRmlyZXR6aXJYMENJbmlZbmVlVFZaaUxld2dvOWZ2WW8y?=
 =?utf-8?B?RURWcmxZTStmVnZGWlZYYWRtbUVaZmNYbC9tSUVpTzJlMUhpQ1dOTkRHQkta?=
 =?utf-8?B?Qmg3djBEUXFBNC9COGpKZm0xcTY5Q3JFQjVHSlhMekllaEp4TTZzOGd3bUR6?=
 =?utf-8?B?Ylh3ZEpxMjloWkNKNDZUdGVqMWRlVGt2bmxPclVkSjFSUkc5clNYQWQxcGtj?=
 =?utf-8?B?bGRFekg3N3ovOTJiWE55b0FsbWloenZGWXd4YXArMEZhNVZoeDFkUGFhSGtk?=
 =?utf-8?B?VkxIVUpjcWxsQnNxOUxqdnVGSmNGQXRDSmlxT2dkcGVuTklhZ0JscVVJV2Fp?=
 =?utf-8?B?T09Qc0prejQvZXc0NmY2dUdmYW9mMm5URHlxd2E0MnMxeE9kSkpXN0x1UFJs?=
 =?utf-8?B?dGNjemt5a3FpaGZZaXFDMWE0am1PTU9ONGRSREJITFA4Y3R6TmxGQ21ybWw3?=
 =?utf-8?B?VlhFQWkvN1o1RnE3NEM0SmlDd29BajNMNDZOaERZSk5LZUJPWjNLOGpHbUtN?=
 =?utf-8?B?NG93eTlrc2NtVVV0Rlo5bmhwdmxsaDRRRDloeE4vaEtMcTVKZWNYT2lDeXBE?=
 =?utf-8?B?eVNRUHJzRzRwZVNRMXBxc3BpekhEaDZPY1prOUFSUWZRYmdmUHhIcGtIT1Jn?=
 =?utf-8?Q?t4lFreERn+INTHq0NeMevBiJI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1723b7-f16c-4d58-aa98-08dd3ac8f91c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:41:40.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkY6vDAkrfb2W6kG5sZUYZenWQbgVfXEo796pQsAEwNoVzMHwiLHELUcNpnaVcY5ngh59FGZVSkQbQjMn3C26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884


On 1/21/25 23:01, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
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
>>>> since r2 with size 0 should not be considered as valid for the function
>>>> purpose.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    include/linux/ioport.h | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>>> index 5385349f0b8a..7ba31a222536 100644
>>>> --- a/include/linux/ioport.h
>>>> +++ b/include/linux/ioport.h
>>>> @@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>>>>    /* True iff r1 completely contains r2 */
>>>>    static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>>>>    {
>>>> +	if (!resource_size(r1) || !resource_size(r2))
>>>> +		return false;
>>> I just worry that some code paths expect the opposite, that it is ok to
>>> pass zero size resources and get a true result.
>>
>> That is an interesting point, I would say close to philosophic
>> arguments. I guess you mean the zero size resource being the one that is
>> contained inside the non-zero one, because the other option is making my
>> vision blurry. In fact, even that one makes me feel trapped in a
>> window-less room, in summer, with a bunch of economists, I mean
>> philosophers, and my phone without signal for emergency calls.
> The regression risk is not philosophic relative to how long this
> function has returned 'true' for the size == 0 case.


Would not this regression be a good thing?

Because I argue that is not the right thing to do.


>> But maybe it is just  my lack of understanding and there exists a good
>> reason for this possibility.
> Questions like the following are good to answer when changing long
> standing behavior:
>
> Did you look at any other resource_contains() user to get a sense of
> that regression risk?
>
> Is the benefit to changing this higher than that risk?
>
> Would it be better to just document the expectation that the caller
> should only pass non-zero sized resources to this function?

