Return-Path: <netdev+bounces-154332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1669FD0BD
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256AD161DE0
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47F13D244;
	Fri, 27 Dec 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JmrwFxnc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B21E495;
	Fri, 27 Dec 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735283293; cv=fail; b=vDlCIn/ULDCNGnpufU4hBN+PE3nk9xrZ7+gfOiXaSv/mUW0hOsNWZb+Iv+P0Cg020HmTqzdsYcbGVwbe2J0zbLkQfy/7f09E/mDg6kV9wEWnisjpb+2BCQy1wXbPR+Ohht+few5QGltfM/FwRCzt0DOHDhT2TSecypSMcNReCUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735283293; c=relaxed/simple;
	bh=4uaoNvydhbdgp22Vs4pdeBkZ6y3rw0DyUlGNHFHXr/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KwkvVWzIBWXxUUh9AkjhE8Mf5Ft/W5UzO/98WsMnQNktOT0J/JjMQHlXb5RKVfb/bPSP9aOiK4KxZnY/RBRGoioaXHBLyX+X576U6iNkaOTFvResh61aIDbiN3tmsmd5nQ+fq07VZ+EnxucA3Fl+N3H8uskFtQymGQOP7s7OyKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JmrwFxnc; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg4JIfaTOKgqu4UZb8oYQttimZHRgZKA4IxYL41+U94zxmV7oHI3PMbi2h/0iQVkpnVWwkYquWGs3iJAK/T5OuHKKStL4elxgUdJ/8lDM56/O23OG4ljGavFdZcYkPxGhKy2A3eBj6ZcWNTmhtEh8Qz8RG9SHRUynoSWtne+/xmbDBrQf2BzaWvXQDPjwux1J/SNXQX64AIbs92pGpGXBXHz61E3Zv04Wn7hL02Kok24l+DTfVpPM5nguJsAQqQArGXOpNc490388LLlazmpVpV7yxDpQAe3cHeRuhUPM4tn+Ne2cRy66c4frCcu8D6bZX6a5EENggQLxc7urozewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5aGCaZIMOZIYMOax5nHjwmXjxo44BhRKU/6h/XyGNQ=;
 b=ESJB5HzNwL2kCfr9KvBLuMwbfDQjm0+I4AC0ti7v39QLR3ZSSY/r6URAKV1J9A3NnP9haXyylkzwLD2NzQwXbIEw99G/Vjnrs4v63Hq+He8VxmC3vf3T4lxgJlt2UswXsmcGj22m+L9eD9ddQRHOynPpbIhWWjB7daTb/lYo8dscAxBdQ/Cebrk81VW9SmDrY4xnrbsrHcy4EZ0XxeSBm6u7gcYhOItd9zGaoZVIFRofHlA56z+mm8aywad6OECrME37j3cWqhxNoJa/h4tC6z2emK73eblyKi2a8dlR+KaC1MQozB2abhJ6CoHDO5n0+he1kHLDl4ZvVeXRYJO4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5aGCaZIMOZIYMOax5nHjwmXjxo44BhRKU/6h/XyGNQ=;
 b=JmrwFxnctZs2GgAg3wVycGaU0iHuBQAbHS38y5x3fOK5IXAPogKWi6SRFTri9y1OnNmc7CGGILoE5diJaVvLQT8wlHSYWyQRFZV2fVl5zJozWhrRzW4cY5lPHv7o2QhSaEhrazd+LhgN5d5Z455oW8BDEhRk2fzMUFwB/wfVndw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 07:08:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 07:08:06 +0000
Message-ID: <81786f5a-42b0-2e5a-c2d6-bfd93b366d97@amd.com>
Date: Fri, 27 Dec 2024 07:07:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-4-alejandro.lucero-palau@amd.com>
 <20241224170855.0000295c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224170855.0000295c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0059.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0718f55c-10f4-4a7e-7bb8-08dd26453621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWpvZXNkUlJvK1NvSVVVUEJDRWt0OUJTclZvT1VHV014cklLMElnRDRIdHls?=
 =?utf-8?B?emxMZTVUM1ZZVnVaaWNocldtYnVVcTlBcW9qU2RndzhSY2RqMHpIcW5adlFu?=
 =?utf-8?B?aDJOemlQa1NrcDZNQXBDcE9qai9PTkJaZ2tRQXgxWnZrUGYvK2FQSWFaZEZv?=
 =?utf-8?B?blFmY0F1eW1kUVZnQ2pUTlF5UVVSbXpjRHcrZlBYZFBGYWRQMyt3Z3pwWG14?=
 =?utf-8?B?Y1I4aXo0ZE8ySERwdG9LdjIvYWhIRytJYXhFdFpINUNpaHJZcHFOM0I5MHNv?=
 =?utf-8?B?WERSWTVQd0tiQVlZNmpkaFpDdk1VM3p0UkRjc01BclgybjgvcEwzZFhTUEpQ?=
 =?utf-8?B?S1N5eWYwNFRmcWYxSzI0Uzl0WEpNdllVMjFJRlVYbE14SUhIN3hpNjlUWDRD?=
 =?utf-8?B?YjM3emJXdDVMOHRFdE5pWGNiZzlMWGFLR1F2SHFGRFR6ZldZRy8wWnVEWTlX?=
 =?utf-8?B?MWd3K1VDU21KVjZheVdMYk1BWmZTRkZDMmI3dzVvR3hZRDgwUzIzbjR3Tnd2?=
 =?utf-8?B?SHpUbjkzeGF2Y3cyMlBicm9YQitUQk5VMk9EYURKdUMvWnlaZm1uTHV4MlUr?=
 =?utf-8?B?MmZoY2dTRXhNOURxZGh1ZEoycTVmVElIeVF0R1k4cnY3bWQzVndjVi96bzI5?=
 =?utf-8?B?T1lXYmx6WUdoZ1hFUDNDZHhYYVVGWlhjQ2hHTWpMZHNGUE5FSVljUkJhb1Ft?=
 =?utf-8?B?c05vVEVGR1AvMDFDV0FpcGNKVWt0cjFtZ2FQc3pwc3lGQ3VXVUJCQUp2Q1VU?=
 =?utf-8?B?NTVuSGZqaEkyVTFzL0ZuMHlGM2tqVTZNT2Z4UlZDRk5idnJoT1R4OGRpU2Fu?=
 =?utf-8?B?L3p2L1lwOVZ4dkV0bnJhazZUdXY4bEZFSEo2NWI0dmdKK2RVaEFIYmxVL0dZ?=
 =?utf-8?B?QkI1blNFa1J1S0tsQnZhbWc3c21pMmVSWWZVT2d5bGw0VDBZWjBjWk5oM2Yx?=
 =?utf-8?B?azByL3AyNjljUXR4QUZTUVRXS2Q4Z0tYNTNBYjljTm5BVm9TK2loVmxKTkgw?=
 =?utf-8?B?WUc5RzE1QVJyZ0lqNnB6ajNGVWJaN1Bob3BuN0llVXNDV3V6SUdWdmJHVVZm?=
 =?utf-8?B?Rjd1dDlDR2JqcHhBU0NXbzZmZkRaNXBzRk1BbW8wTFlURXpzcmh2MXBEQVRG?=
 =?utf-8?B?YWZpdVRUdGYvcTRHaFYycFRGakhYdEVtZ1NDbXRLQTBITk9mdVpVbCtBZzhh?=
 =?utf-8?B?Q3Zma2w0RmRuaHBtemxpRVlsS2FvcUdpcVFhYk9Vak5zSllhaGRmS3pXTFFx?=
 =?utf-8?B?TzFQOVg5RHhldkpLTURpTkZmSkhJTEh6dkVxV2dRUVNIZ3NlRDRVRFBTWENI?=
 =?utf-8?B?Z1MxdHowaVVrdEJYL2VwTXI0TkRxYW9DenBxbldrc0thVjZuNk5JQXJMdG9k?=
 =?utf-8?B?YlZJNVU5UVIyT1RiNVR4SmhYZlU4V0FYdXdzbkVVbXhJVEdyRTFwWmhoSDdo?=
 =?utf-8?B?STdFTzExUGpjUFhIWlRhREdkMGxRejZ6R05oUEY3dTdIZ251UWpPQXRyYmhI?=
 =?utf-8?B?VDM4cTVhVG5IdDQ0SklVbGE3bVZPck1ONkNlNzBnbWxPd3o4QjQ5Z056d3ZJ?=
 =?utf-8?B?YjNnRUJLbWREZkVFZ254ci9YZUt2NHBRSUFlaHpSMmM0NW9EQnZHSlU0Nzd2?=
 =?utf-8?B?SWE1L0pLTkNsN2doWTJxcUsyazZCRDY3Y3VHcXRxTjQ3NWRMb0JRNnVSVG0w?=
 =?utf-8?B?OXdiRVFBN25VU2l5SXc3R0h6MGlXakZqc0ZqdUhyYnJWZloxOXF0dXlGeVpk?=
 =?utf-8?B?TkRkbStYeU54K0taZzQ2VC9FT1VaMXFUdmxUU0svN3lCVzhaRWh3cDJDZUt1?=
 =?utf-8?B?UkoyWk5wSzR5Z2JUOGRIV0podGhCV1FHRXBJNkMxayt0Rkg2OXVVRERMeFJL?=
 =?utf-8?Q?5IupG/LfgDBVd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVRiVGdCRlV5Rkw5Q1lvV0tzMW1jNTFqQkYxdmpMOEVuSmd0TkhRZmdsUUl0?=
 =?utf-8?B?eGF4eVR0QVlhUmRTSzZ3S29leFEwOUg0QUZ6TEVRL2ltN0F6SXhmUVFzWHla?=
 =?utf-8?B?M05pSlJ1WGFYSzlLb2tHZDVqbjlCRWY5S1Nnek1jYU5FUnJMbUxvT1ZtbzUx?=
 =?utf-8?B?UzlPRGN3MUpBbVZmUkJqcnB2MDIwajhkSlVBcmU3SmUxaUlsWDVsMC9rNUhq?=
 =?utf-8?B?Y1k5NFNxejdnc0lDRzluZ3p0dCtHY2F1RDBpSElHVytnQjlyK3FZMDVCYm9P?=
 =?utf-8?B?bndDQ3ZKVmg4ODk2dXRFR3pIQVg3R2pwZ1dWaTNwU0VTZXNFdzM0bjBwRTVH?=
 =?utf-8?B?MVc0NitIcm4wY1FySEZ1NWJkUktMUDZidW01bjk5MW9kcHVpRi8wcWZCaUtO?=
 =?utf-8?B?OWNJai9pWDZrTjZzcXNtTzI2b1o3cG1pRjRNTHk5aTRra0ozTE10OG5DajAz?=
 =?utf-8?B?QVRNRDE4ZXFpa2RzUUVDMVFjWXA3RkFWb3BsRmtrdVVEVVpEeDEwNWRiSEw0?=
 =?utf-8?B?c01rTlB1eVBVQWtQS2dCNkhpbldoTzlJOExWMXlJbnhGYW5uRk9JTDI1Y1BH?=
 =?utf-8?B?c1pvcFF1bG9sYnVBcThJTlNBRmk5QWhXNEova0tneXFMa1p5bGZnV1FMa1VB?=
 =?utf-8?B?QlJOMGJpeWFQdS9EUU9xYmlBMUhWTDM2d1BOL01UNmJOeEl3VGdoaE1HVFRx?=
 =?utf-8?B?Sit4MFhYVTJGYTFrOGN6N3FpZnB6SE5nZkVVWXB6L0pzcHNIeXJERTAxMGQw?=
 =?utf-8?B?K2JObkN0aFVSN2M2MU1VMUhMMmNvMXhERGsyUnNvaTJtVFFZQTAyQVdpd0dv?=
 =?utf-8?B?cThucHpkZFp5QVc4Y1VRZkVSSWJqa3JFZmY2dGdYRklPb2JNdXFLRjRFbzJY?=
 =?utf-8?B?V2FmRXprR0VKaTM3S0YyMm9rODQ2MVJUczF1TWk1c043YzlmLzU1Tkw3ckV1?=
 =?utf-8?B?cUplWjJpWDVpbk9xbDF5enduTElPRGZpclJkOUo1Vm1idWh1SFRUTWlVbjJr?=
 =?utf-8?B?dWltZVBSZXJWaU5qV2xXQTRwWk9kWWR6cjRNb2t3R3hmc29lbmxuNStuUjRZ?=
 =?utf-8?B?UmU2UktNVmkrQVVDWENoT1hYUkxMTzgrOUxnSGxsU3YyR2xZS1hPbDl3b3dy?=
 =?utf-8?B?VFdNcEkxRk5BMUt2MlFSZWdUYnBQRTl1TEMxZHhjOWt3aDlPUkg1UmN6NDdZ?=
 =?utf-8?B?bXNZL3BzVTNGVHRDekYrVFl5V1lkYjByMmtYSFdERytWa2RDbmlwWi9iRzBq?=
 =?utf-8?B?RjA0VWtTSmswekRiQTM0NnkxYkJURHp4RmdPRDVueXRhWSs3WUgxSGJ5U0Q2?=
 =?utf-8?B?bGEzMVRUU0NBaHN0VUQxSDNHZjlxRW9ycXE2OE1KaHlLZkRlNmRFNHRJbUN2?=
 =?utf-8?B?ajlSQlFRUzZyR1IwQnhGbWtrM0V4YTV2NDA4cC9TOWZ2NlRxVFJudkREVXMy?=
 =?utf-8?B?S3pWNWdsYjFFeFloQnREdjFlY3MwTnRsNS9QTmlCVGtBSC9RamFmS0kvRDQ1?=
 =?utf-8?B?NHZXOWVLNDRTSnhkOHFGekk2NXJSbk9SbGI3NTJkcVVTTm8ycXkxWTRQaDVw?=
 =?utf-8?B?VGoyWHlyNmZzNGIyTExVbXNRRUpuMjdtNFhqbTdvUzgvcHhOYzZMczZmaXZ1?=
 =?utf-8?B?M1ZYbXlRU1JiclgxSzhMcHhBZ0RRdWdTNFNjb0xqMmwrUkx3azJMek5LNGM1?=
 =?utf-8?B?TXI4a0FIanpvOUpBcUJSYnZtN1NWUE5kOEFFclA2dXhlY2RJK1pNMSszd2FE?=
 =?utf-8?B?VVdLbnJUT2JoL2NzZzBUMUFiMzNvanRNVGN4TU92aTFWQ3dZSG11NUtPeEZu?=
 =?utf-8?B?bFBCaTZvaEJ4OU1wTjNJODMybGRubG9ZeW9JZHc0RWgybmM2UldMS2pCZFFj?=
 =?utf-8?B?L0QrM1VLR2xiU0dCdWhqMGpadi9jVmlFUXJxV00wOXBORE1BMTUxRXRpcjht?=
 =?utf-8?B?UFFVTXJGeDB3ZzBKNytXU0RXOUw4eWtBQk01NkVNSFZ1c1owcWVvdE5PUHhp?=
 =?utf-8?B?dUVzSnJEUldGWXB0bGorN2l3eVBUV1FHbHhxRWRGWkd1WG1zYkhMU2tkejdv?=
 =?utf-8?B?YkxaR3IzdVZVampzZjQrSitoclp5UldDTVZEYUh0OW5WSG9oU0pUMytZSGlR?=
 =?utf-8?Q?Cuvxpo+44N+g3aTPldly5hOeI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0718f55c-10f4-4a7e-7bb8-08dd26453621
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 07:08:06.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcCNdNHWsfp1jYObQosjzOPmIirrTSPHNj0FBkveQ/RQaqX+6wLJ6/AgE/thFgy/rg1HY9XcXYPa/qTK26369Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170


On 12/24/24 17:08, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:18 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field to cxl_dev_state for keeping device capabilities as
>> discovered during initialization. Add same field to cxl_port as registers
>> discovery is also used during port initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Use set_bit() not dereference and |= to set the bits in the bitmap
> At that point you can void need to force the length of the bitmap.
>
> Jonathan
>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 59cb35b40c7e..ac3a27c6e442 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -113,11 +118,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>>    * @dev: Host device of the @base mapping
>>    * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>>    * @map: Map object describing the register block information found
>> + * @caps: capabilities to be set when discovered
>>    *
>>    * Probe for device register information and return it in map object.
>>    */
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map)
>> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>>   {
>>   	int cap, cap_count;
>>   	u64 cap_array;
>> @@ -146,10 +152,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>   			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>   			rmap = &map->status;
>> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>   			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>   			rmap = &map->mbox;
>> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>   			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>> @@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_MEMDEV:
>>   			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>   			rmap = &map->memdev;
>> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
> Ah. That would will be why the 64 below. use set_bit() for these, not a dereference.
>

Makes sense.

I'll do it.


>>   			break;
>>   		default:
>>   			if (cap_id >= 0x8000)
>> @@ -421,7 +430,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>   	map->base = NULL;
>>   }
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -431,12 +440,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	switch (map->reg_type) {
>>   	case CXL_REGLOC_RBI_COMPONENT:
>>   		comp_map = &map->component_map;
>> -		cxl_probe_component_regs(host, base, comp_map);
>> +		cxl_probe_component_regs(host, base, comp_map, caps);
>>   		dev_dbg(host, "Set up component registers\n");
>>   		break;
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>> -		cxl_probe_device_regs(host, base, dev_map);
>> +		cxl_probe_device_regs(host, base, dev_map, caps);
>>   		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>   		    !dev_map->memdev.valid) {
>>   			dev_err(host, "registers not found: %s%s%s\n",
>> @@ -455,7 +464,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	return 0;
>>   }
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 19e5d883557a..f656fcd4945f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -12,6 +12,25 @@ enum cxl_resource {
>>   	CXL_RES_PMEM,
>>   };
>>   
>> +/* Capabilities as defined for:
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
>> + *
>> + * and currently being used for kernel CXL support.
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_HDM,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS = 64
> Why set it to 64?  All the bitmaps etc will autosize so
> you just need to ensure you use correct set_bit() and test_bit()
> that are happy dealing with bitmaps of multiple longs.
>

Initially it was set to 32, but DECLARE_BITMAP uses unsigned long, so 
for initializing/zeroing the locally allocated bitmap in some functions, 
bitmap_clear had to use sizeof for the size, and I was suggested to 
define CXL_MAX_CAPS to 64 and use it instead, what seems cleaner.



>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

