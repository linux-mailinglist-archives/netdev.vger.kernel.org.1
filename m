Return-Path: <netdev+bounces-62738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C5828E4A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212191C23A8F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 19:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE53D553;
	Tue,  9 Jan 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0rsj/Cx4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEE3D968
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6nGKvCqXcvziyLmUmvC84g4dkdNbVu1/Zqybpj9rJwt2RmSzusC1Sb9K/fx2Kg5MzfrYzKKbKZy1oxbYf5cpOpxyHIhHoziLTYITsm4+eGRqQ6vDlx/aQaY8aJ161S3FxucH9XGcTYvrvXEk1XpScjnTc9kMu9qRinRUM6pUh+Y+LVlMNS7TllrvLA7rZTvHNpr8ptYb5VNuLbgU4mBP8HeqA/sUOQnfXuvyzaYxgKSxVI1dWasZ5RBvc60L0wSBOr1yB8F59LBxVzrysGcvNWFGlw1vp7AKI2x5UtTzPn4m5Nz/tNKq6w2QtNaw0yhvu1n4E+XaIM5cvHEUGln/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkG15L+a4LfTDe/PnydS9Q2PqOFGqmgs/Ebc3MUvvuk=;
 b=ixtNu3H+ZZrAHefGOen9W4Eq4YJg1ecoc8b5YxotZjNSapWuy8X36Z/fDRs2HckCjrHFfL/vPfDmaPMm11T50iYCJBzlG4NqpKZRkoCdWcX4FyA5HQI1955OPxr+gRyawWR6oXfSaxio/V/TX8AUvdUyGjaknEIDBeDMC9w2p30SX5LclzPJg3e7AE9L3KGpmDl/6QqgXChw4mHFnC6yQQprW3HCdqafLwT8jiJMPc800KBUkpg82HV9xf6amVaRQw0vy7rSx5qNyWFCgC/T0lJgdsO/vrWA2iaYm/h+/2uS8BuPLoQA1yI/thWP490CIuy+9A9P1KSkOFFol+2OMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkG15L+a4LfTDe/PnydS9Q2PqOFGqmgs/Ebc3MUvvuk=;
 b=0rsj/Cx4fQPDyOYLU007J9ymtLPEkWKNdziSBcjPoXzZoKrETfHjI2x5KT1sj/d/z4/Ss0AfeWI0WEdChTFJTs6Dd1O0zm3vEIr8J+c0hx7fBWxBzhlWi5BRFlffR1PqGGpjxd8Sc20X4uEVr78GC+Ge4HvUdc4gkJ5my4twUR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:56:50 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 19:56:50 +0000
Message-ID: <780fd221-0ab9-4750-92f7-93cb2f645f60@amd.com>
Date: Tue, 9 Jan 2024 11:56:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 2/3] net: wwan: t7xx: Add sysfs attribute for device
 state machine
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com,
 nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com,
 felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
 <MEYP282MB2697CEBA4B69B0230089AA51BB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <875ef470-4cc0-4b68-bdcd-ea54e2ef5271@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <875ef470-4cc0-4b68-bdcd-ea54e2ef5271@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bc6e6e-4177-4d05-9244-08dc114d1e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s+ARrciNONdfG7yX5WHwU6NpsLBvUQ2mg72HwqecCGIA/AqEmwCpAa9+HpP/RE9JswLR6aL1Jg9N1UA6hUOWjSo20kUkeRnlSG2q7UddtJgWXCXllB6qzsGIfaD6vfQapweNkSR1/KUTc/0njSxeZqCXmhOVjqiqv7iTGl1yZAj3xSSnbe+Xf5HlhQ9FcM9FnmZ1NbwFNo1gkjJh+a57BmUtEtHy0TZYWmHiNdZm0Nzf+JEkKo9tC5GfkznAfz9Js845F2d+p/F4fXmLw8uuKF6mOl+4Ruj3uLbxu9NcVohDndUdwFedcLe3rOxT764g/LflV5AynucAqcfOlFyHZptqN5lG4+A6A+5dtCEuYWtGVWOjaa5aY1kK2m1eQotNabwojULbyqu3Y/s1awHUj5xy9pihWXl9l5GvOAphEJlD+qBP24Cc9J6fc6+SZ9+A7u1izl0RcIzNQ6ODYlMVOtJv0NOe2iF2v0C5WgzzyK8jToWSj4KNyOHxLOZ4DEpSnmWobQ/2LOdHq9tOxsam/dVVeZP4ZZCzXwqcOoKcz87YChhkM3SPlohpEf/SKk5HBJ9Mjz/STMrYsh3M9TPuswR26NV6/FDMlcCL3emM9Q8IfmiqVw9hJqjD4lpzThgoqr4j81k9KLiuCt8Cq7FbDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(26005)(53546011)(2616005)(6506007)(478600001)(6512007)(6666004)(966005)(6486002)(38100700002)(36756003)(31696002)(86362001)(4744005)(2906002)(41300700001)(66556008)(83380400001)(7416002)(5660300002)(316002)(4326008)(66946007)(8676002)(110136005)(8936002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1BxS0tUN0FzQUxKZld4WVZQQWVWUC9EL0ErWHFQTkZmWGx6L3JGYVFyTGo3?=
 =?utf-8?B?T2NkTFo4eTFoZDBiMEQ2a0VvSk90NXF3dGtDS0d3MXRZUUdzZTgyK080SW9r?=
 =?utf-8?B?SjFPSzRUbzlISWV3SE85djJ4cnZ4K3RXSFhCL1VXU2xsNXQ2YU16QVdtTCtl?=
 =?utf-8?B?cWlUclVGUUc4NnF5ekw0SlhvQ0NGbmZSaHllazZUT2FwZjQzYSs5bTg2T3p2?=
 =?utf-8?B?UHhSeXZHRE9VKzdrWlF4QzMrMmFBUUR3MStSN1VFTk5QbU5NL1QzL0Vyc1hS?=
 =?utf-8?B?WjhMdUovZXM2c2pjRVlDalV4RTEzWnJoK2JTZGRLUmlxdUJwMEI0bzF5TUM5?=
 =?utf-8?B?SHdHVHlGN1ZNMDZRNzFXeHVNVnZyVTVSazBnMHpHTjZWZmlpalFId0N0UEQ3?=
 =?utf-8?B?STVOWThoY096TXFFdUQrOCt0MU1qbENKcEhlVlU0VnNpdG9FejdkdWNxSVd1?=
 =?utf-8?B?cnFGUEt3S0RtRjJBT25BWWtEckc2UjlKazJlajhPdWFhU2NZN1Jqa25aWW9H?=
 =?utf-8?B?Ry9TR2libUErWENDRmE2bUJrbVVtUVVmWlVTR2lmSklhS1p6cnNNNnJVWmFs?=
 =?utf-8?B?eWJ2RTBQeHZEcGRDdHBmWEw3VkYvVEdPS1lKMzF6aEhLT3MyZldhbkFONUNh?=
 =?utf-8?B?VC8xTHFOUnNmb3NxaEl4UloxcGFjM2s5ZjEwM1JHbkIwZ0FyeXFRUDJ2QVYy?=
 =?utf-8?B?VVBad09sd0l5bWR2UVFvOUF6ZEZNZWRzaDZXSTdoY0VYeGltR1RhN1F5UVBj?=
 =?utf-8?B?cXJvWEJKQU4zN01vbFR5N3pUL2hId0xuQmFOUTRHWEtGY1dWZWRmMmRqL2xU?=
 =?utf-8?B?NFFsZlJUS0UrQ1BmK0dIcmpXeUNoNTFsUEpLNnlTWlB0RGZya3Rodk04R1Fi?=
 =?utf-8?B?Y0FNd090MDlZZ2xXdGlXVXZXblIyc2hIUWx6YVo5SEpNZUkxd1UrWmVWMVNv?=
 =?utf-8?B?WWhOYVVQQVRKOUR5Y1VCeVlEaDNGTzJtQkM1d05heXpJbEJtMitXRXNIQlZl?=
 =?utf-8?B?cStzSk1vcERwb2NLV1cxL01DYlVQWGlGdmtiL213WVYyejVZcEh2bmJGV0hV?=
 =?utf-8?B?R3JLMzdSaWhLeHA1ck1WUmp1Vjg2NXZQTHBmbjZRSHc2ZDZ0R0tHcXQvTDFh?=
 =?utf-8?B?bEV2RGJUQTM5ZEtJS0gzS1kyNVdSK3JMeDFKTkZGb1E4YkF3VjV6UFgxdnVO?=
 =?utf-8?B?clUvcEUrWDlGaFlPUVlRTWdXbnQwTWpIOTJuWFRxZkx0RlpYR3JHdENSaFIz?=
 =?utf-8?B?UVRnY0FTVWJvSmJremcxTjdUazQvd01JUlZFeXdnZTVoRU5LS2tSVjJmeU94?=
 =?utf-8?B?QjlOYmNJTlRxMi8ydTltUDVHdlF2MmJUdmZuR1VLTXBkUlRLaUUwZkxEM0ZM?=
 =?utf-8?B?Qm9Ia1lUS2RNaTJQSmxQeCswUWpFT09wUmpNTHAzVUYwdlIzY29QcmhjZWFT?=
 =?utf-8?B?L3dWMHJBZUZPbkhDcHJQN05MVEFBTk10cnJQWUpjT002VVVhVWh0UW56Wjh3?=
 =?utf-8?B?SThUODRzUldKQW9tVFV0TTRlQzJteG5KSTA1a0FUNllKTnVqNklnZGFaaGx2?=
 =?utf-8?B?K2RjeXNMT1A0Qmc5Y0k0bDRKdkhqME5lcFUzcmc5djZueDUxdmxmK2NWK0Q3?=
 =?utf-8?B?VzZqNTlzWjlnS1VaWm1Va2pGRktnaXR4SnpyUnN5NVhxYkRVRjdNWVJZaVlI?=
 =?utf-8?B?Q08xcFZEcTJOMlNSQUgvQVhOR3NtTEhhbWgwS3I1UkF3Yys4UDhVRHkyaUFW?=
 =?utf-8?B?MVk2NExBK1VOdlNFRWVHTVdCQW16OG9MSjJEdTRzVE1iU053blhqWVljdklY?=
 =?utf-8?B?ZmdCc3hqOFpZMko1SkVzQnVibU5PZmZ6UVNDRnBZdXJub1pMNURUY2E3RkFW?=
 =?utf-8?B?UjkxTUx2WXhEdGJlZ0F2d1Z1L0o0bEZzdWJydnhISldGeWlEd0tYN0pjbmhV?=
 =?utf-8?B?WkZPN1U3dnk2cGFmcE5BbURBQUJ0czRDUHhrVE5qT1RDc2NERk11U3JHYWZV?=
 =?utf-8?B?cWVNK25rNVFNKzdhUklUSjN3TnNRU1c5M1htQU9kRGxRN2VQZllqWlNuNVFl?=
 =?utf-8?B?Rk1kTVRQM2l2cm13OGg3QytjMS9Ebi91akppa3pZYmV0WWNUeVlaU0RFSFNj?=
 =?utf-8?Q?gRaogWomkI6bgnENSACqJ7wud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc6e6e-4177-4d05-9244-08dc114d1e8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:56:50.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH5uDbMY8gzn7Gvm46BzEJC6+8/wknleAOGHF3vBokmQan6HUZsGOdHjwytsa6A2rbkjDEgfMCl5/IcuMPoEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

On 1/8/2024 1:37 PM, Sergey Ryazanov wrote:
> 
> On 28.12.2023 11:44, Jinjian Song wrote:
> 
> [skipped]
> 
>> +     switch (mode) {
>> +     case T7XX_READY:
>> +             return sprintf(buf, "T7XX_MODEM_READY\n");
>> +     case T7XX_RESET:
>> +             return sprintf(buf, "T7XX_MODEM_RESET\n");
>> +     case T7XX_FASTBOOT_DL_SWITCHING:
>> +             return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_SWITCHING\n");
>> +     case T7XX_FASTBOOT_DL_MODE:
>> +             return sprintf(buf, "T7XX_MODEM_FASTBOOT_DL_MODE\n");
>> +     case T7XX_FASTBOOT_DUMP_MODE:
>> +             return sprintf(buf, "T7XX_MODEM_FASTBOOT_DUMP_MODE\n");
>> +     default:
>> +             return sprintf(buf, "T7XX_UNKNOWN\n");
> 
> Out of curiosity, what the purpose of this common prefix "T7XX_MODEM_"?
> Do you have a plan to support more then T7xx modems?
> 
> And BTW, can we use a lighter method of string copying like strncpy()?

A quick note from the sidelines: better would be strscpy()
See 
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

sln


> 
> -- 
> Sergey
> 

