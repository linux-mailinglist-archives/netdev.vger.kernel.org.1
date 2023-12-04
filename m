Return-Path: <netdev+bounces-53450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CCD80303D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8665B1F20FB7
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FD20B33;
	Mon,  4 Dec 2023 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mEtc7Hv2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFE119B3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:26:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2Et+LezFjQd2fDgAk5Yt4Zu+WgIneBG8ZgzErJkji9NinafSFZBu18gGbrm2suxXzIOuuplyif4NFOWmAogKsZ9cV55bBK5WO5IHkbe1Cr7OG2d3ZRwtywvkOHMKLjRxMRUX2Hpz4rx8kS2SFqKR/z+lTKinnxwdqyOnuV9csU32d8oeC9FCU31tI/pOAX9js0kCDe0FNhsALF4g6bEjBRvv3Ki0p3RGx00Iu8rIQWEz5tVMFleubkOGqy/gujeoVDkOCs5SxuvL8kEo1YNv2F0Wk9sELlVS99hM65drreczFw1RI0Tr9HaKDJLL6Q5/DeqfwBbRWw5GDiJFPZdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3zwE5sEGkamj5KotWH4SDLmZcyEr5fftkggn2/bOSo=;
 b=gMNyiL0phLxjXATRRe9o55DyKy48vzmLcLdBJ+EEMz6XhmomBAtqj+/A/pVKWj0ngA4Gz1ppz5oSwnzXaVSkGft+v1Kh+OsMnvZkpAEpEpftS4RK2IsVF+PgpaMYoJ/28JeT3QVE34D8VdXTAfbQZjf7ExMhY1F34aIpV3vOO/91KpWdccPdyZj8geeGRWkmnJJpAp633PRZy7pqAEHsTxvJcGHhGXzcSfmnMRWW4ifzhzORrU0l1NE/ZFkTSEyDu/MDryne6YUVWRUOZmoWxntHkCnAK//PgC7ytscBHRvQRw9CQUT9XfSRtL96Z7SHOR7eiDFaWRiIRlPYjsYpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3zwE5sEGkamj5KotWH4SDLmZcyEr5fftkggn2/bOSo=;
 b=mEtc7Hv2vizsboIekvXYKGBMBwNG3Nfk0iYSWN9YOO30nIq0d30U7VWPTM2kai1YJglpD99aDm2Go+XYbfvFvl7KWvJQNGWijJ1GmYnuzzmXIJAu6jk8NwgKmo4k103qJb247+WjE+Ln5yl3ydK45UjNqza8Zc5mbFzCbJkFjzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:26:36 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::23e8:2f3b:86ac:ba34]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::23e8:2f3b:86ac:ba34%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:26:36 +0000
Message-ID: <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
Date: Mon, 4 Dec 2023 10:26:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
To: Jakub Kicinski <kuba@kernel.org>, Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
 <20231201192531.2d35fb39@kernel.org>
Content-Language: en-US
From: "Austin, Alex (DCCG)" <alexaust@amd.com>
In-Reply-To: <20231201192531.2d35fb39@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0265.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::13) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3090f43b-13b3-4908-647d-08dbf4b37e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	651Nr4SZU5S8nCY6wiMRS6P1sHRps4lmLLC+FONNwDXoIKVkd6/bO+0ce7dwq7opYbnTGepk0qs5LTdJJdPv2XwxRuYUSOYKY253FZw9EnrVY2DRMrnBFYLNCxdQbvvVM+e/l8j0iA4Cof3rrC4zPP8P3OrM+Qh+hUQt+SQCFwiYRDq1juNFdo4UdE7moCurrpqSWMnRMwARNWzrKyoK61gqlBlbHK5FOGaKD1EEVUEyuVJZmUlzLmgUUP6sbqXT6OHUiKXFzI/RUn2JikrU5wwMmv2GTNlX1MLqqsYe4ihdhA2on4ENjuMbB/vrYmQu9hc7zTwUXKbiVsVaKK7E76yCWRT3Qgh++wSufGIwUpio3oRTTm7Z9cukR7dw0hGD4GZjXL+6q6onqpWvRzKxPRAVfRndDwtSivmAmwX70IL2GZXtui/fCsVK6E89/MDGbXuRYtpPfeIY71Je9JfpElKGPoRD8bifrJFzgnGEAVFEfjypBd5WzB1UiGlxyeD8jnNxhONrR612CvyIOS59M1a/vBmGGVKGTAPfNH8YjKoj6VqzEWO88Pf7IcbljMpVORdMa+4KBMcv4VTx7W+4x5N4Jet3YbJDtHbho7QvPDdWk2BlETUBuvxiRV6R0OAhrxyFXYlkCS95UIEIFsVMKBw9LaeGzJCksTGHhqBBFqR+MDEGKe/Nkb0+7eCIXr84
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(4744005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(66476007)(66946007)(66556008)(8936002)(110136005)(316002)(6636002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUEzOEJWczhjNy9tQTNJSklsRHltSlljVlhaQzNJOSthTzVqN3NQbmdNSnhN?=
 =?utf-8?B?SzY1VHBWQmw4bkhWemJ1cGNFZ2t3Z0Njc0ErVFdZQld5cVZucnJtVVE4TWlU?=
 =?utf-8?B?QU9IYm1nMXFXZThoVkE5RFN3NVVXV0FqbjBDbkhyWnVYdEh5c0hQNFpDVmhE?=
 =?utf-8?B?RDU2bk9pYWJpSktJUjBoeS9teTB0TGpxSEovcTlkK2tPMjFjTkhRdUlGQXNX?=
 =?utf-8?B?QkxCNXp1MmkrMUdzNkI5QUN1TUpiWlhSaEx1TndERFl2NGg2K0JHL3JkUkdM?=
 =?utf-8?B?Nm5BdEljQ0I5VHNuNG1hbnNCTFdERVlGRW1seFZrUkJMUWlVTGMvVlk1RC9Q?=
 =?utf-8?B?Y0N2OXhhUWEzL3N1UzZmVHoxK3B4QTlydlU1UytRUk5jUE5JaTJJSDFQeklW?=
 =?utf-8?B?VjVhUnFPa2xYeFlZRlVrc1p5YTE3ZXoyUkcyblc3UUJ6NWNib3lJSVB0enVq?=
 =?utf-8?B?WCttM1Q0UldiNkRIenM4dGdtQ2xKeHRKajdPSjZPa01YMWRiK1pISisxcEdD?=
 =?utf-8?B?M1g5akpaOUJVRVppY1JvYm13djVPWENJTU43aHdBKy9NMzNNVDlxdWRxQTI5?=
 =?utf-8?B?Zy9hVzdrS0Z3V0JseXBxWDhRcU9uc252bG1mcm00VmI5Snd3U0t4RFIycit6?=
 =?utf-8?B?Qk40ZS9ldE1qYTFtKzk1NCtzYURlaWl4SUs0ejBVMTMyc3lxcytTNEtxS1Nr?=
 =?utf-8?B?SkhKUEtNWnZLdDJqRTdyVVlSZFRjZ2huenVqSnFTcUVaazgxMmpjTFFZTUZT?=
 =?utf-8?B?YzlVTDdCWjMzUzBXSXQ3cXkxdEI3eXdhbUtwemc2azhQak1pamMrVTVFWXlS?=
 =?utf-8?B?SVJTOE4renNOM1d2cm9MeXBpdW9KSEViUlJWRVg2OXdCOVNOdEU5VWYwd3ZM?=
 =?utf-8?B?by8zNm1ISWtFSFViMm9XZUQ1bDlBaFh3L0hQV2xocE5RNmFqaTJPUzRFdE1D?=
 =?utf-8?B?RGNLb1RUWlZhNFByRjZuZlVuQ21OK3A2ekxDZGVCMmFyRUlLNUJKbzY3d0JG?=
 =?utf-8?B?cFpRR2JMd2hldlF3UURzZ2pWL1pDTkhweVBCTUdlZGdIeFhJUkFrNk9MUTFt?=
 =?utf-8?B?YkhoTEhwRkpIRWl2eEdUR05WU1Rvb3FxQThtMzB1ZXNJYmxZU0ttVVErM2FL?=
 =?utf-8?B?M3lCcEZ5YVZkeEFvTGVhVGpTVE9IWUhPSFFjRndNcjBaaS9XdWgrN0lKZ1Fh?=
 =?utf-8?B?T0MvU1NaTC9OSlFRRUJXZ3RWN2U5UVdodCtSaHhMdlh4clpBQlgvS3dvQ0gx?=
 =?utf-8?B?azZvS1pwOEt0M0xPS2N0dEdhQXpwOGN1Z25qelljSFlXK1RFUFkxUGtBeVJs?=
 =?utf-8?B?cW8vSG5DK3RWNE9zaWduUTNFVzgwMlE0T1N5eHlLWHVLQWFCNDREZFUwNmJC?=
 =?utf-8?B?OVJnR25QOWVHRHV6NXY0cDVOYnNYRi9UVjdpUEV4cjZtTlNCVUNubjdpMkhT?=
 =?utf-8?B?UlZNOE9LVGZXRENTYm0xMS9oblpGSDhyd1lwYmtRNXBrZUFGZEpYVmIwT01D?=
 =?utf-8?B?V05ic0t0emgxRi9TVkZZTFZrLzl5bG01RDRxL0VVT0NidUwyMi9mN0kzSjRr?=
 =?utf-8?B?Y0FDQ0Evd0pTMndBVHJseXo5czBjYjI1cE9qUDhBeXRzU1g1UkY2cWNlV2w5?=
 =?utf-8?B?aGNrOEE4OG4zWjNkSG5zRzloODBhSlJUQmVoVEk3Zm1seU90bW92UTRrdVBF?=
 =?utf-8?B?eHBHZ0RNVGhpcEt6b3ZMNUZqR1B4Ukt3LzZwazllVkZYWmNzbEtSRFhHS1RD?=
 =?utf-8?B?R08vTWovSjV6T1poazlYSFVUMGtuQ2F1UUR3MFF0RDVOZHNjN0IrUytkVVh3?=
 =?utf-8?B?eDVJUEtZVzZZK1g4RCt5eGN2TUVoTzdmRGxrV2EvMDFkYWlhZkVoZmNrcUZ4?=
 =?utf-8?B?RmtFWnllTW95RmNtZ1R1M1M3djkyNVV3SEN6SDJIK25ZM01BK0VSUit1VU9u?=
 =?utf-8?B?VE0wRktIV2pNalIxRHlWeFVvSTFrUXAzd1hXQ1lLeklUc3BaSFJCbWdiNWdt?=
 =?utf-8?B?Rng0UXovK1hhWjVVL0tJQ24xelNuSUtQL0lGSjBMdGJQUG1HZk9ORmJROEJM?=
 =?utf-8?B?cVpncGl2SlRVUGkrU0lXSDFYNHhRcWgxZHNIcEJqV2J2T2NGdm1rSGxpUk5I?=
 =?utf-8?Q?RsWxMqqNWdLDpmgq0OE1ljEwq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3090f43b-13b3-4908-647d-08dbf4b37e79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:26:36.3364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HM7AmEOAb6zJ/o3GKmakb6RGVOB0gImOSftYOwJHx6YR/+ILmOy5Ui0AhR/jygt+qwkCG8uNPP146XenJiHcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

This seems like a good approach. I'll re-work into a v2.

Alex

On 02/12/2023 03:25, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, 30 Nov 2023 13:58:25 +0000 Alex Austin wrote:
>> -     struct hwtstamp_config config;
>> +     struct kernel_hwtstamp_config config;
>> +     *config = efx->ptp_data->config;
> Do we have a lot of places which assign the new structure directly
> like this?
>
> There's a bit of "request state" in it:
>
> struct kernel_hwtstamp_config {
>          int flags;
>          int tx_type;
>          int rx_filter;
>          struct ifreq *ifr;             <<<
>          bool copied_to_user;           <<<
>          enum hwtstamp_source source;
> };
>
> Maybe keep the type of config as was, and use
> hwtstamp_config_to_kernel() to set the right fields?

