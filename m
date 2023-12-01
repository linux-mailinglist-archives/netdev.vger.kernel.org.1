Return-Path: <netdev+bounces-53007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32128801102
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D21C20AED
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806224E1B4;
	Fri,  1 Dec 2023 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZmUoF8F0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896AAF3
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyM4XuuCV/nW8q5GX8JdbutEhqf2NjVwBBPhx58AiJ5+fJOMJlcr831sG7dsE6zoF7MAbIONLfHBPyfIlpwTky/VwngO5yKHxO3RBhtBJtaUMPcK9z1Y0EDWDGvfgw5z1gtNaSGi7vxoWV5hnbGRxtZU2CzNnLCufe+A8cFr/TKAW/pjCMQZev65sdx8WlVbgOV4ZtoppTWoqE8rMjlGLxyhG8Wd5tE+u8bhG6YIYOgIklRtp3oSYMhIqFmgTchqskMK6XP7cunp6+gtfcCF35QsYGr9KeC61HYue8iQzV0HcMWEqVBAO8Z7rYgf5OdoM/b8voQgf3UBIgGjPpRXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk2zvWJXin/PgwiFSRw0TIOwa29s1Y/svegoGp332m8=;
 b=FqY3r+6yLN6TAz71NUmZmshHZfb+k9JkAj1MoD/s81pUYI1lTbxqW22wDHJENwcM067Hl9xX+G3wXflm0yqhla0RoGMJN/G77e3QUP8XH9wd1iTty4O90ZU01PMxi5YroFzQm5fqlbw/YsbwjrGnENHihKbniwMEEFVDOKpI0pCqJDgwgWpbq1WgY0mVR5GcXRyYc7pI6HwfXH3D2ucazim2aqDr8pYmiiENiAYSwtOVC5sv+tAiTfBNKYkBstrodDz2zyoKXkxwa6JcJ/vWKiBpmcqHiHr9boQ752rm2qpCUoHUXk4qxPd2AKiAyw3tkja2uOdZDPpzRlbEhpFfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk2zvWJXin/PgwiFSRw0TIOwa29s1Y/svegoGp332m8=;
 b=ZmUoF8F0WdL3qLyn29V2feBW3RZmTJxKRbpPofoZQrZlWk7crb4eMoF3lqdq1WlJsypbdxHUwszi8GugpYkKbaa08pTZzvFMyefTzXvT0Nwuegit+0DPNSVZ8uAlB5p8ANMWbaptAGm99TVEAA2WccQdWlKyYdjGAy1SApdVlYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 17:20:05 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 17:20:05 +0000
Message-ID: <b78caee6-806e-470a-b0b8-b5cf86941b90@amd.com>
Date: Fri, 1 Dec 2023 09:20:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] ionic: small driver fixes
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20231201000519.13363-1-shannon.nelson@amd.com>
 <bb0bf95c-84c3-46f5-882f-23074a5e66c0@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <bb0bf95c-84c3-46f5-882f-23074a5e66c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: f841dfca-5259-4e41-508d-08dbf291c26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6JWRMmJOsV13iWSHKRXtMIRxvzG1rxQg44fGy0Z7/skil1vGA+0fqR+b5H6DVAjWXVsHtIQiK00N+Z2cRTV1+VLeJe0LoMR8t3HqMzuoXpusdzwTYVEA3n29fCt09FyPMICLht00ce3gX/7azVOdnyuEzQcAOi8aWghAKPu5InrqE2ljc5R7AMqN5Vgfv366CA/44uNlPvb0nTlPLBjTgFSpWrfvN1WyLcfOumOXJftC/UBjx+TMIuWJx0CgZx7WeIhNwClYYwa2kBCsUPaZmv2esrFffAU/w1fM658BzbTiN4D5VwCw7nFP+NjbVLa70wY02jZoFipOQzD9HA9T4UDiy7Tig1d2D+Au9nkFw/JS9E6BjlvxwyhQGnqE0K/sbACGMd6gLMNzHOsW+7ZWnDtPJVYcMjyv/wp/wBa8scEWsyRjexe3ld7BVeNQMUh6RV6HD5TruFe87eqKPCfhhh8nWVglQwTywY0MqzE2X7RtrFcJuG9emdsROFEjkDLTw0ZcsaK7KqJv54vCbyfBDP5KFqz9c8jan8r4rdhQR9u/FHG0mrnGvJIC37cVGq8mBzZQpFxZi8/Uh5hUR3cZ3RqGhKGKsT0s+hGBji4st1FZ5EFfvbs1gnDSfCWOelQ6mmuKGlk3hpyOMq6+DDsv8IUoCyfa+EIcQ17IZ1/G3U3hXDqohJGRG3uXVaZ4mkj4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(86362001)(8936002)(31696002)(66946007)(4326008)(8676002)(316002)(6486002)(478600001)(4744005)(2906002)(41300700001)(5660300002)(38100700002)(2616005)(26005)(6506007)(6512007)(53546011)(36756003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkt3VzR0SlR2NjJGcmRYMnlnM3F0SWpEaW1tZzQ2azV3Yk4vVkpjeFptMnRM?=
 =?utf-8?B?YmgyUC8rbXpzZDZmSHptU0RlUlcyK3lmM0VlVWY0UlI3SnQ2MlFNczZiVXBY?=
 =?utf-8?B?cVVDWEJyQ1dTUVkrWUdEOEdnUDNqM3JKcEt3dFlZYnpkYlorZmptK2VkaXZa?=
 =?utf-8?B?cVEwVEtwR21ibUdCWFNQTVlRbGgycTlnVi9oMUIxcEFFemoySnFpR3I2cC9L?=
 =?utf-8?B?aFA4S1dwQzBJNmdNaWVHdEhIQXgwVHhGMkZLV2tWTFFuRUliZ3d0WFM0UjdM?=
 =?utf-8?B?UkpYOXQrSmtFU0RYNjF5aVdUaFJzSXhEamYwRjZoaVlDb2Rxb1I4T1NzbzNa?=
 =?utf-8?B?ZXJucHpwWlR1U1RUMGlhSUpNMVc5WEw1aCtLZVgyT0JqaExuMXcxNlMzVXcv?=
 =?utf-8?B?MSsxZzhEeE5UaDRKdm9Icm1IUFg3QzBXMDlhS2p6VmZPQXlHV1ZnSkdqMUMx?=
 =?utf-8?B?UE9aTVZYYVh3cmIvRGd5TTBqblM2RUpXZ0haL3VuaXFjQW9sQkVXNWNNWTBH?=
 =?utf-8?B?eEhOZDBRblY0b2JnVXM0TWlteUtDWEIxYURpSHd6RGpJSmNKZWIxYU56TmRG?=
 =?utf-8?B?UU84Q2JjdTU1LzFVRndKRTVoaVUvMXMzejZQeE1mUlB2ZGd3M3BxMC9CbTBK?=
 =?utf-8?B?RkJ3RXRDWjdCUlZTZHdoWU1oL0lSQ3VwYlp2NFJsZDM2QS92K3N3SW9hdzhq?=
 =?utf-8?B?ZXJPdTFvdzdiK2J0RFJydFFRbnZQL0pvUUY2UmZ2d0FtL2xNVmNtaitiQWJY?=
 =?utf-8?B?TTdhdjRKWjRzTTFveGZTaWNRU1lXS3lIYi9xenJwdkEySHRyTHhWN2had2RH?=
 =?utf-8?B?Rys0NS93M0hZTUtBSW01QTBKWlRQMk5XUlY0OXF3RFJ0VXJCT3FUcmZxV3FE?=
 =?utf-8?B?cHJuYTBaT01SYUE0TnArREVBaUM2RHR6QVBkaTNtaVJnQSsrRUllc01JMVNJ?=
 =?utf-8?B?ZjA0SXFRa25YaDFvdTBRN3RraWgySzlSRk9YaUFINjBOdUhucFBNVEJTWDRv?=
 =?utf-8?B?dm8zcXdUOUExenRtNGRNYWFiclFBS2FuKy90NDh1RTJYNGNqcnNHcVB2M0lr?=
 =?utf-8?B?ZzdGS0tvUmwyNkRpdTl5VlR3Qm1kcGRVQnJjVS9BbkpLV2lUQ0VLa1BqUUN4?=
 =?utf-8?B?MmxaVkt4SWFGbW05b1FkTHBZTGJXeWVoaC8vMExRU0dtZ1ZzVFl4STBMbHVk?=
 =?utf-8?B?eVM4anFLNmQwbWVCNTFPelRHT21CdWR3QUlsczJuMlUxeE1LQUh6dUtZdTA5?=
 =?utf-8?B?bm05RmVIbDVvUVdldXRqeSsxSlVPMlJFM3REazhNT1lYMU5VSmEvbzFQdU5C?=
 =?utf-8?B?MllpbTMrQUxBTlRwR3ZEUGE3L2s3V1I2K0VmaG1XODhDVEpPY29jZ2tqMDFr?=
 =?utf-8?B?WFB1dFFaS1d1Z1VwUVg3Y3I0dVdOZW5ZL2czWGNFR1FIRDU2UVhpVGpjWm9T?=
 =?utf-8?B?Wk4xbkxjRW4zUWZjS0RkTENSTnhUK2tubnFXOHN5cUx4NFhIMXdpcFNhWW02?=
 =?utf-8?B?YldqQTd0N3Z0SnovODhBZldNM3NYMWdDK3hkUFhIM1VncXlneGU4UEQ1cjNz?=
 =?utf-8?B?dUFvMlZubmswdS9LOFh3dzNMdklTVjIzZnJEZG1yQVNnSVdoVjZnanhLRkNK?=
 =?utf-8?B?UXlkZDllQ2dVd1dSNGl3akRnZ2lzVTZIOWorektqaFZrR3crZm9Kb3RzMzYr?=
 =?utf-8?B?dVA0WmJSZXppamVEMk1uWStIK3RhMGVZR2tORHJyMC8vRkxqSVh0ejJGMFJz?=
 =?utf-8?B?TmQ5dGNPQlFQOFNkSk8xeVVLeVE3OUFGMUVxMDc2Q3hMZzA1S2JZSFdzeEpt?=
 =?utf-8?B?QXBQbjg2Mm5iUXpicDhzbmpWNFhsQ25oYUVGSnI0V2VhdkpYV29YTnJNS0FE?=
 =?utf-8?B?MlJsYk5NQkxhVDBMenAzb2Z2c0YzWG1VMDlKMXN3Sms2dW52UVZVTWVBNnc5?=
 =?utf-8?B?bnBrMG9GT0RvM0pocXZnekJENUJ4NnpUeXFaNzNPYVFZeW1sckRVZUdtRmpy?=
 =?utf-8?B?cEkrZkVoWkJ0ekhybHM0NE1OWFhRc3d6QUE3REZ0OWZnalN2QUNmTmxnZHpN?=
 =?utf-8?B?ZXhwa0FsS1VjOVFSN1lHSWJHZGwwbDdwSDJSa3pwTG5xMWp0c0tpQ0E4MVd2?=
 =?utf-8?Q?A7wgubre7Ar9sHoCvvSgX4vW1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f841dfca-5259-4e41-508d-08dbf291c26c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:20:05.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGEXCp0s/gAb4mFoK0fbC65TY3nQUKfrSNJT5sy8NZPDD+hyKlk7cvmeaJ0TseJHqOFqZiVDzLbqmjs0GjOINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921

On 11/30/2023 8:19 PM, Florian Fainelli wrote:
> 
> On 11/30/2023 4:05 PM, Shannon Nelson wrote:
>> This is a collection of small fixes for the ionic driver,
>> mostly code cleanup items.
>>
>> Brett Creeley (5):
>>    ionic: Use cached VF attributes
>>    ionic: Don't check null when calling vfree()
>>    ionic: Make the check for Tx HW timestamping more obvious
>>    ionic: Fix dim work handling in split interrupt mode
>>    ionic: Re-arrange ionic_intr_info struct for cache perf
>>
>> Shannon Nelson (2):
>>    ionic: fix snprintf format length warning
>>    ionic: set ionic ptr before setting up ethtool ops
> 
> FWIW, for the whole series:
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Clear and concise commit messages, nice!

Thanks, Florian
sln


> -- 
> Florian

