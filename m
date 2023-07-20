Return-Path: <netdev+bounces-19296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B675A318
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489201C2127F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D14A198;
	Thu, 20 Jul 2023 00:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D07F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:04:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A8172D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmYgi99nzSblpws8snkbOYsCXXP2vtT0cC0gJrLVOMrX0KDyFMlYGW2RcO+NNTVt0lrWKEVZyYCm+2GekUwPVzTc5XRWAsAqZZF7948pSIpr2S2BHz3ckxaD9zuRf61KF9X6YUN6vitPA587AQV+R9CR6OKTxb9gjMHmcDVUlefM+ip2HY1sJMf0Ny/f8YKtLiVypqbM45SgQ2P8qZvc5mtBRWeu9IXOW3m39RcPcBkDG+ssSWv+L+ljdnnCQATY47cU76sc1v4C7bIOQfjy7VRnHvgVmP3TvQCqgpirQefZAI05er6rV5gF0evCW4xYNesSoJ5i6iMlwx9tSXsnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hZc2UewpfUTTorJU4QIG+mIiIKVeZl/NcOFxjOSG58=;
 b=XBrT6nhn0BEBC0bL8cInzZWXDQU9cSDuCLSYKmqWdSfcRdppJMcmrIMcpukNcxc+CrG5Frkjhl3sq/lT0dg61Te1bYEcjcOL7ZbzIz83kHTnZakFr3GTI99XK4u6zcVXotHe/V6+WI6ThMvAqB6UpTp+klI0CvV4Ru0zp/O+NfYegtg7eToH0BhU3XL41rXqWns6B3+D6LF+U2/VPAEu71ZfHA7RHLWTxEIeozNQfZGsUeloEhjr1/Ut7uXt2y2uWgS6AGyFCgOUBSRr+K9lhRjCIGjKtp+FIBSqiWIm7RXYi/xpUkeXhumJHf6o2zzqff9p20ra7oriCYKSPXuFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hZc2UewpfUTTorJU4QIG+mIiIKVeZl/NcOFxjOSG58=;
 b=npCDWILkfWTfosUgv3mzHFXltkgOAMfGqA0ylYy4tpUH6ellmaqlPQ1DfYVVg3VaYKikd6sM7hkSEmLQsSG8zyqGjzqVXnfU8H9VizMUk1If+ZO2huypI3/qNt+bxHggQ7IK2RWD9+JaIl4D3HaJcSXt3WzhynrVISnNwtPFSyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 00:04:27 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 00:04:26 +0000
Message-ID: <e6d7ed36-f5ad-b000-57d1-4f48644bd81c@amd.com>
Date: Wed, 19 Jul 2023 17:04:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 net-next 3/4] ionic: pull out common bits from fw_up
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-4-shannon.nelson@amd.com>
 <ZLgjs6a2KJ3xEh2s@corigine.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <ZLgjs6a2KJ3xEh2s@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c621f02-b363-4462-1008-08db88b4e1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XTuYZQhtHDW3tD391gwBMYBUR1e3huWebmcZI8YNcldNxqa89ODLHmy/gSjLkLwCAcrP5iXwTpZG6wT+PEqF+PAQG8WA7FEZletThcBBuKpeBfElxJpbxVKH3bQQP8LfaECCO1Rf36beCpkvgNoswBE8oB2PlhZhvupWd2E4IIdSkJB9a0my/Do4nlQeta+Mdf9uYsef6TN4v9YAuOi3dt6TeYox/EGSPBRcSfqBg7FWm/WnL0/bEGCN9QEM5e8NelKJh26XtZIv0sSfQbbSz4kPccPASt8PRQctlEd3vngpU7Zxdu6PrO+0+YgY45tXuirsZ0lLagCo+GkYdBdzfMj+CSSjhFhrcRPUEU2qndkLEBZqq6UuKuZyhTICWVZJa9Y8l7RjzrpJ3Tgic/I37ORPzdg+zO53/rOY9zah72+vmrFNeHktpCXW2ggLROVZVV/Wp4krF+h2bm+CQJes4EOcLQP1K2nOpnRF13FYZ++0O/znzUfp40sOoLDFbwKw9aXIkmX4sGbKlfxGcOh+qEyjBxGnx4dmkfZu9SnGWjdq4eGMao5NPPer6BW5klpMmXOkXFznuwMY2W2s3nXQ5NsVzF4sf9lfMbp4tMryAJEpdwng5WI42ImZldOxbr949MKteATLWSNguu0mPPZ7mQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(26005)(186003)(6506007)(31686004)(478600001)(66556008)(66946007)(316002)(4326008)(66476007)(53546011)(41300700001)(6916009)(86362001)(8676002)(8936002)(44832011)(31696002)(6512007)(6486002)(5660300002)(36756003)(2616005)(2906002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE03Z21oYmE3Z1Z5Y1RKbGVTTTMvcGhpYmFCSmdITXdiUjMzM2dGVWV3djRD?=
 =?utf-8?B?RWlBODkyS2hGbzZRdlZaSTFpRVRYWlo4YWE5WGFKdUdXUnZ0WFRyVnpacFVz?=
 =?utf-8?B?MUtaOW1TQ0hDbThRdXlEamc5NHIvZzBBWHBGdjJKcjRKdXNRRWxBVVNxNlRq?=
 =?utf-8?B?T2NvSElLeDZTUkdGcERwNWhHbVFtQm96RkVoZ3ZSS0dlNUdZeWlHZWcxTTM1?=
 =?utf-8?B?Z0hCNWMrdHJ1UXd4bnYvSTBNOXlQa3VUcmEwc0VtRHZzVFhKejJrT0hmNGRF?=
 =?utf-8?B?SEJzZHpIaHVRTkh4Y2I1WXAzQ3JZZldBbTI2bmpnV2JxRCtSOEhhS1RaY0Jt?=
 =?utf-8?B?Vng1UFBZc1FIdTFETlBGb3VTVGNYaHg4NUZGVThDTWh2UVhSR3NqSzZaY2dV?=
 =?utf-8?B?N1JiMERSQ01Wb3FuOWJzT05JQjVqeDgwVkJiM0gvTm5RRFRWbUpSTHF5YStH?=
 =?utf-8?B?Vm91NFc3Q0gwcUhvSE5IZElxeGxnUDNQQ2tNdmZzUkpFV2FjZlYyN2sySzRw?=
 =?utf-8?B?ZGczNFdhV2VNWTNyYWhHWTdNQUxRV1Z6R3E4TU1XTUNaRGZFdis2NG15dDhG?=
 =?utf-8?B?ZUZ1Y3RMNllYc1dkZ3k3RHB1N0hKMnFQOC9VWWk3SS9BVTFhNjA2SU8zbDE4?=
 =?utf-8?B?Wm1qSEZGVDlkb0lzTlZibmJrODdPMU5uYitiaDZNQnkxSFNZdUJYb0twaG50?=
 =?utf-8?B?eXJpK2E3T0pRT1o4aTRJa3lRVFZGUkp3VDNkOG8zVFp6T0xLeFJNVGlwR29t?=
 =?utf-8?B?Zkorb2xpai9jcGE0UXhjUnNwQjRxOEhvd1NzNUhUZm9sZnAvMHVvUXROVDR5?=
 =?utf-8?B?VnNwRlVrNTB1a0psRGtNQThTeWlrVnBkcjRpT0dJN2ZYakhJOHI1SFRNOGZw?=
 =?utf-8?B?ejNCcU9naXNlb21qaXlzNFk4c3hYL0k2S20wU0NSMFFoY0tOUTBTN3dWblha?=
 =?utf-8?B?dzFhYUdJeUs0VVdqRkxRRGU3WUJ2VGVLK0Z5WEhlNTFGbXUvRnpIdFFYU3E3?=
 =?utf-8?B?TXFOd2xqSGorVUlGbkMrRlA1aTgwM29Xdnd4bVdHQ1dwcDNRNjZBMjB0UklT?=
 =?utf-8?B?ZlFDOHdJSkVld2FaZS8waUNNQW1RdTZYNzRIbzZjaHIwNDRvc1l6bjhFcnhq?=
 =?utf-8?B?MUthdUF3ZVNZUE8zUG9YTUhVMW0rYkszeWpnVHMvOGkzdWtSSzNBRS9wZHJ6?=
 =?utf-8?B?eE9DRVN4WnRjUnk5dFl3ZWxJbEhDcVpBb2ovTk1iT0tMd2pCUHE2dGdLRks3?=
 =?utf-8?B?R1hDbEJ2dlZqL3YyU0oyRHRxNHluN3dPRTYrMFpjSU81RXU5US9pN3JGNmRB?=
 =?utf-8?B?MzFZVVZZYVBNNTlTSnJvejN4NENWTmpjMWdMaWwwNFhLZUcydnFWYldBS1F1?=
 =?utf-8?B?WlcwdENSdEowRXd2dlUxbWF2N21Mc2wrY1lvUFB4dFBxMHp4aWhsdSs3VnRD?=
 =?utf-8?B?eEErWkJvVWFaKzlrK1RhT3dKVmNFSEl1TE16cm0ybytMWVJUYzVNcVVWeU5D?=
 =?utf-8?B?QkdFekRHc1BiOGdlWWFWTXY5Y25pbGNNWUZqUGZMWVg4cW9KY0xQK3I2ekRt?=
 =?utf-8?B?THNoK1ZNbDNKeDJTNGcxZzkxSjZhR1FuUGM5bDUrd1dJZDQ5ZzVHRjBMUnJj?=
 =?utf-8?B?UUJqeWpBQzhlNFp2VmgySVEveFNrV2tYVnZaQzh4Rit3TFZzMld0K0RKU2dE?=
 =?utf-8?B?Z0YwY3pzcU8xWE1HdjFWcCszN0pOc1BJT2FYeGxzdUgxSDRLVC9vUzF2VWhn?=
 =?utf-8?B?Z053T1AvK3U3dWM1ZUlOK1VqZVdzWHlJa2NJTUI0dW00clpYOGFjb0I5bU4z?=
 =?utf-8?B?cS9SN2dqbjBKdUN3bTZESlJRRWcySWxnVFlSM05hUlJmK3FYSW1JYkRRd3RD?=
 =?utf-8?B?Q2tLL1M2bEVaUzVCQ29ZQXdHa0RYaFhvdDdzWG9GMzFETHlyKzNkOVl5dmpY?=
 =?utf-8?B?eU05dTM5ZzdTaDRBOFJUUFhUYnplNUlubVBjaVBlcDJpL1hkWlRRWThOazIy?=
 =?utf-8?B?NG14L2U5RHZjbDd0bnVMY1lEU0toeUpXZ3Y1M2p4T0FTdGZiNVZFclA3QTYr?=
 =?utf-8?B?MXJITXJXV0xobnZGdmc0N3VQTE5TM1lTOExIUkh2dnFUaW9SSkxmdFRzRnVX?=
 =?utf-8?Q?ZsBMbfRfEVKG1fMgnqaeBp4i8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c621f02-b363-4462-1008-08db88b4e1d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:04:26.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho1LTu2uDFJhc+pQz0Lr4U0lo4IWi0YsfFUaleUbxv/tTzQQ4MBYorMl0iIOUs3KxZEdhRZ6RP49S0avnUZNMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/19/23 10:56 AM, Simon Horman wrote:
> 
> On Mon, Jul 17, 2023 at 10:00:00AM -0700, Shannon Nelson wrote:
>> Pull out some code from ionic_lif_handle_fw_up() that can be
>> used in the coming FLR recovery patch.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...
> 
>> @@ -3317,17 +3301,13 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
>>                        goto err_txrx_free;
>>        }
>>
>> +     clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
>>        mutex_unlock(&lif->queue_lock);
>>
>> -     clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
> 
> Hi Shannon,
> 
> Moving clear_bit() inside the critical section seems
> unrelated to the patch description.

I can make that a separate patch in the future, I'll pull it out for a 
next rev.

Thanks,
sln


> 
>>        ionic_link_status_check_request(lif, CAN_SLEEP);
>>        netif_device_attach(lif->netdev);
>> -     dev_info(ionic->dev, "FW Up: LIFs restarted\n");
>>
>> -     /* restore the hardware timestamping queues */
>> -     ionic_lif_hwstamp_replay(lif);
>> -
>> -     return;
>> +     return 0;
>>
>>   err_txrx_free:
>>        ionic_txrx_free(lif);
> 
> ...

