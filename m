Return-Path: <netdev+bounces-34331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AE7A3452
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 10:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37441C20A6B
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612F184F;
	Sun, 17 Sep 2023 08:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5737EB
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 08:31:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6F6199
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 01:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM8Js8r8AJqIMX//3qdpEfS3MOEA6QDmeVq0xZA7O+MqsB0Kd9/cwpYhtlGyhcxg9CKPsRSRVBadmFexMqg5mmQpZpErJHA5HiFOHdDnh7bO1s50yRXh6E6dvw38MMcegVmI4lDHnYcGVDniZ5QTGMUkIe/mU0qsD1Ima6jrjSSCL7BOslKwBGbkbsZrEDJOzmJdridg0CVYp/RtcKR0seSmqziweg98D+/EhHU89BI/VoheHdnBVimcPXcJt543AjtsIJzmlJ8ivDPixiktE4FsOyxtNpxWM6f743wOfcfMe1HDVRQrC60snh7YsnOsYfCHhiDP57KCL58L1N2Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVv3eAMUAp/BS6bOlKj5IZV/v3VZnMjH5SB/OeUABv0=;
 b=gsjxkl0JmsfQLK5SE35ytzs8VwKKalMBMuPHPelJy+jM/T+RylUjBfdh2BevkJiufsI8w2v8klqeyyiRScUGrc/XC0CfdiSRALXDOiBp1+bl+egRbwbW5oXAXe5ujLYpIWBbnOMZO3CWvFzoN1/exaXYe4HwfCLVBTTrLGjGTA4Mf4QN70G799457eJks50Y+/Pt25NqNV52ylqdlHVncaYghAA1WTAoon5kQHj4GLU6Xz6Bff2Xq74pEofZre+EjyiIPCmn5Q1Y7LoP1lS5DCmu2V8AcENo4IobbjB27wtiJTIgOrojlyrWZ3000a1+PSom1ZnafWOQrlJs25NFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVv3eAMUAp/BS6bOlKj5IZV/v3VZnMjH5SB/OeUABv0=;
 b=i4iejgFbjsIvm+HVxTwguL9DDlFvwCBePLWkKWmZ5rAHY62dWqgt5WRC+/mtcdjY7TbYpYpkp9hjUpgsF+IFj7SUkfj55/YdIec7yiHXo6NwNJlzJ/4VWCG36Ucv2Jf8nnwjw19nBs85RfwMFmJcXrSJttJrLWTv6exJz9IR55E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 08:31:16 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::e928:75c9:bf10:292a]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::e928:75c9:bf10:292a%6]) with mapi id 15.20.6792.023; Sun, 17 Sep 2023
 08:31:16 +0000
Message-ID: <703cae60-5898-e602-f899-06d795b58705@amd.com>
Date: Sun, 17 Sep 2023 14:01:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
To: Tom Lendacky <thomas.lendacky@amd.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
 <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
 <d6c6b06f-4f90-62da-7774-02b737198ce0@amd.com>
Content-Language: en-US
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <d6c6b06f-4f90-62da-7774-02b737198ce0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 863d918f-31cd-44cc-dbd5-08dbb7587597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FoOn9ZJvJfNXSAMpInyzVdgh71ZE2FtGFFjd+FxB8wm3OKdQ+8+evPSMOjHQURLEoMYi087k72o7gJZC61PqFUTkiIC1YeE/fns/dqjToW5WS3+xlJt8Fe1mxK0/0FrNwbGrvBb33nCxWEig9OtM2KmJuJFDxO0Cv7q/PQYq01VFkSmhSqniStyNVyhAkXDTYvtxgf2Lf6JCaCQLSeBsFlrVqWfigfQeU3LTG8c+T57t/9o9A4Ci+NfdNPDQCaJV3+1eOZVdoD1+hCHfTpQ3ad2TdZinWaBWtjPTfbhCQIldidxRIesM6IpHEMvPVYU4qX8bUBfXQhPVgexELuK+oGrdCsp84rPQFarTBauCzZsSGQXIn7YbEVZfLrTm0rU9/5sJrvk9cdzfMm1tEZAI80Yzy3mGT+lCMfntAidMMiITkKZqm2AZEtyEd2nTQD7Jk+pvDif+xb2OcHY8Zbz3LMemtKKW7wYQgvRV/m8S3Ilj+cv85Thm33BWMMXVy2kFpRwAox0nr7yucqZL15rhziLeMeVykyhMH+Aswi3QLGqqA9p+gxBhpvkzISxouEuBvgAoCGiHnB3+Ug8CxWCVHF/8Pa6MuR1H5aOPR6YWqLEqUpheswMHwLRhWihnV+RcG6B90yqhjPH3aZYRQx6jmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(396003)(366004)(186009)(1800799009)(451199024)(6512007)(6506007)(6486002)(53546011)(6666004)(83380400001)(38100700002)(31696002)(86362001)(36756003)(5660300002)(26005)(2616005)(2906002)(31686004)(41300700001)(8676002)(8936002)(4326008)(66556008)(66476007)(110136005)(66946007)(316002)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxrZ01tWmtrWGowSE9TdUtyYTdwbTVuSlNab2RHUlN5Ylozc0hxQzRkUXB2?=
 =?utf-8?B?QWtYQXdORnRWbGZZa3FTQkgraTVCQmlockhaTUt1ejBJa0hNWDArNGVxcmpq?=
 =?utf-8?B?SVVSQzhqWlJwL21pRVV3NE9ET2YvaU1NZXlLMVdPZ1BxWmMxM25OZ1pVYWNx?=
 =?utf-8?B?V0ZLSnA1MFZjdU9VZkZScUZCK2F6Q0RWTWhqTmJLRzFtYSt0aU9jUktYbndv?=
 =?utf-8?B?NzJ2RWhPa2FXaFhISm1xeDdFcWFlSHNtNG5QOFJaOUVCREpieUhXMG90YWdF?=
 =?utf-8?B?WUFqaDRJKzRzT2FLTHVEZmR1VlQ0QVpabFhKbklJek92OW5DSzcxL0ZQZHlz?=
 =?utf-8?B?MWprRUUrM0RUOGt2VmRZcVN0U2IzZklMd0hmVmhOVTJFQm5YZzhYQTdkd1ZJ?=
 =?utf-8?B?WTVnVkZTOTVvN2liZGgrU1QxSXFlWE1lLzhuQmYvT0o0ZVFIcDZwakVRa09X?=
 =?utf-8?B?THE3UmpCaDVYSGJ3K1pRNG1VaHZjbWxPQit2SmRRaUg0cDV1VkJCc0p3dS9J?=
 =?utf-8?B?RnBqS3Q2dXk1U2RIT1V0bC9hNkJURDk1SWNpUnlkVDNKdXdFQ0ZhSTZKTC9U?=
 =?utf-8?B?RVdOMUxjcUVnUUFzQ0NlQUh2aFljQ2pYcWxjTTFuR3orbXlHU1A2MVFRWjBn?=
 =?utf-8?B?ZkFWdVhvTkc3aFZYU1NBQ0RycXNSb1dEcWphMXRUaWdwTjhyVlBxQ1J1SGNS?=
 =?utf-8?B?WjJYQjFzQlVlNXF5YlNqNmMwWURod3BodGhib0lLcktPQjY2OXpQZnlGM0pr?=
 =?utf-8?B?Mis4UnZlT3A2ZzBzWEZkRjlSWDNjaVpBR1c2bFhKLzc3ZzdwUWdhbW5RVGRG?=
 =?utf-8?B?ZHpRWVd6MStBdlNRMEwrWVMrNFRsYThvTElNTm10aFRiTlhKVlY2MkVmcDgw?=
 =?utf-8?B?RTU2ZnIzdGEzSFJRd2krNzNBbDJhQ2hPa1RpbG9vZnpYVUFnNCtJWDdYMXZt?=
 =?utf-8?B?Z2pocE5mOFlXZGRDUXR6bitUQzJVQmE5ZExZajdrR1VxeWtsT0ZpaDRocXUx?=
 =?utf-8?B?a2FrOXRWTDc5RUFGL3FEMHZLQWRDbHc1Z1FqL0pCWmJYMFRiL1ExZ0J2UEZL?=
 =?utf-8?B?S29aa0pJSDV5UzJBMmdyQWYwSTlOTVpwVjFvSGQ1K3V3K1Fzak45ZEVWYThz?=
 =?utf-8?B?UU43eU5aYytQK0orcHR6VDh6eXJ2YnpGNy9nRmd4Yld6bitrNEFoUTZDRlNL?=
 =?utf-8?B?VEx2UTkyOTJVU3NabTZLdFd3TVMrcVB0YVYwWElERmkxQmdjeWYrUWtmMTdF?=
 =?utf-8?B?L0llRElBQ3lwVjVqbnpIUy9yMlpYMUtVek9XcXhObXhuTEVjOVRKbGhIekJ4?=
 =?utf-8?B?cExxSHlhTHNqTmNQczJqZ3MrbXM5WmVOUEFBTURVa0pEcXBuam56RlllMWFQ?=
 =?utf-8?B?ZU1GK3RvZkF6MlJCcG5CWXRNdUhROVJZWURiTWxGNTltU2pKUkpxTjBNNi9w?=
 =?utf-8?B?YlNodGowZWJOWm8vQ3ZvQm5lK1Q1RmVmcVNmbFIxdWR1MWF3aElBWHlPNWdJ?=
 =?utf-8?B?OVpXeVk3ZDJGUEM4bFY1Q0I4YWhiVEdKSmlPaGc2TlovZjVxLzJkU0NCK0w0?=
 =?utf-8?B?dFBYeFRuTnhIYURDaUVGNlc3bGk4ODBJaVhiK0dzcU5iOG1oMU1YMW1LNE1S?=
 =?utf-8?B?UnA3U3hBMkdZQ1NpOVFHNVBpNWZpYWdoTGtPckh3QW5veS9GUVVCeEQvbVZG?=
 =?utf-8?B?NjFOTGxYdHhoN0VyenJwVDlzQjNUQU1lSXhRZ0RBbVhsa0VqL1lHUGFKV1I2?=
 =?utf-8?B?UUEwUFpNeEZLS2pIck83R29qM1Z0OHZFdUtxY0VoWStvOTVnaVNXcXN3cTZM?=
 =?utf-8?B?bjBhYzlyc2tQeC9HbnAyeHJkazArS0w0YmVLTzI3eWluVHVDMjZrTFo2eFhl?=
 =?utf-8?B?Y1NObDJCWFd0eFdRZi9xdkJOS0I5RkIrNTNURks5RXBodU1MR3VQRi9mWU42?=
 =?utf-8?B?VnBuZHpFNU5nbjRoOUdmdktFaDBKOVFvazU0OGp5K0RPY0xleVNuTU9XdW5O?=
 =?utf-8?B?cStiVS9uckxPRG1ZU1J3TDd6dllhU0dOSld1ODVJb3Z2SlBoT3FWdG9KSWlK?=
 =?utf-8?B?VDl5MWxQMkg3MFdKbVVWV1hCZTFkUVJ6aFE1NVRHRGpIU2ZJZGN0UEFkZlFW?=
 =?utf-8?Q?JSoS+YIWE4oQw/ANb5qIMaNjm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863d918f-31cd-44cc-dbd5-08dbb7587597
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 08:31:16.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mhr3tIS0mFxsoVsVg1W+5LaJtfOkqZmxJh6HYqNaiO5uNaEz7hOz4hAR4PYKnN0f/A5DbEUWg6r4alKLGvpuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/16/2023 12:48 AM, Tom Lendacky wrote:
> 
> 
> On 9/15/23 07:41, Andrew Lunn wrote:
>> On Thu, Sep 14, 2023 at 09:49:44AM +0530, Raju Rangoju wrote:
>>> Link status is latched low, so read once to clear
>>> and then read again to get current state.
>>
>> I don't know about your PHY implementation, but within phylib and
>> Linux PHY drivers, this is considered wrong. You loose out on being
>> notified of the link going down and then back up again. Or up and then
>> down again.
>>
>> But since this is not a Linux PHY driver, you are free to do whatever
>> you want...
>>
>> Also, i believe it is latched, not latched low. So i think your commit
>> message is wrong. You should probably check with IEEE 802.3 clause 22.
> 
> Granted I have an old version of IEEE 802.3, but "Table 22-8 - Status 
> register bit definitions" has:
> 
> 1.2    Link Status    1 = link is up    0 = link is down    RO/LL
> 
> So latched low.

Thanks, Tom.

The following thread (found online) has the detailed info on the IEEE 
802.3 Standard that define the Link Status bit:

https://microchip.my.site.com/s/article/How-to-correctly-read-the-Ethernet-PHY-Link-Status-bit

Thanks,
Raju
> 
> Thanks,
> Tom
> 
>>
>>      Andrew
>>

