Return-Path: <netdev+bounces-32978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3279C16C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AE11C209EA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CFA55;
	Tue, 12 Sep 2023 01:11:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD263E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:11:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970FE1A2CBD
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfH8BnZIrQI044lKszVp5tJISo4clVOw+ttJdy2N+yKe8aXYIUOTr41Aks4OjY6AJyIyyYdysVUxoeALI71PWfW33ZmvqJa9/S6vABl0Qs/B3Vpzvw3JBFIQx3SBohqQ8qOLQhA0Haia9OmL/hqH0VyxnN8B+T9Og4BewWr/3ATBd7qMDtPa1Sq5uojN9glXq9IkR1npsYoNLUY31XEuW7ympo0IgDPWAG/rnYKQZ1T2UFvL7aPvdDkNmuzPVNAoATMnt6Qk9N6piQgCuMtNMzbnFKuNGdILEOcjpbR6ETkM8MkjcX/Ab/aJvwLwhB9aWhQmvRsYG/zCWXgTQ1HToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL5cwb9VNZK0euohevK02toSqQyw8w1FZGeXGbKTNpM=;
 b=dxIbPo0Cv2IRr9TKZNV7HaxiYqq5+obeuTWzfKQFcRyZg1nvjAbdksLUyRLMz21ihzjdQvOkvHFkfQLeZJ8RwZAvg9qP0NwTe8axYIfXfY54g7MDW1UeO0pxMQHUpYvUJmFnb26Mdk26Llx5N9DKaMiAgKdkj5IVl8Qewu+gGcY/XeXcim04ZeRhanhUNQfzInp0tqclbULijIjtjzuUGZMXBCId+RAB0RwL/mKQOJ3fF5NxB5r3143WSRyITm9LNbJtd/RrJO+G9fFbMXfzcw1h2ozjSxRunYvl6t4C5rAq+ZdYWwDNRkJotwxMycbdnn/jQrPcK3qviQLqebU/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL5cwb9VNZK0euohevK02toSqQyw8w1FZGeXGbKTNpM=;
 b=2Y9ga+B7CqA7RHac05eiOrD7+xDNlkP5kKJMbru4TiPMDYLmcmQ+tUNThMjYDZAUcl5z6pE1VRUK7gK0q32jHMl7oSJOWqauuzohxUzOn4rR5Ukc7xZXMz1xrk5p0EGJ+NHEkf4VlnkU86zysXMzKqzkS3pKdm0qNp+NzdXneQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 00:24:31 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 00:24:31 +0000
Message-ID: <a7c39c89-c277-4b5f-92c0-690e31c769b5@amd.com>
Date: Mon, 11 Sep 2023 17:24:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
To: David Christensen <drc@linux.vnet.ibm.com>, brett.creeley@amd.com,
 drivers@pensando.io
Cc: netdev@vger.kernel.org
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f49a232-ed1c-4bac-7703-08dbb326a1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pDSZ1QWBEnaOhXXE/MVxr2C7nAB737826I4uvW/qNGi8FkNZt9OyJWRmQdFw7Ck/xat/vpfE1Zj97hRNW2/tEQcN3LgYFfC+j9te3GbF99ybzTFbzYsdJAeayVmXyqoF5bQXelXCQXggirGXXc+8/3voiYmT6O2gULR/1gBd9ZDprxMb8gcExmYjtcqig/xA7WaapH50XkJCN2wbh7ZdCMoM9x51NjvMrFPAYxf8IebeGsVqRh+sJUMdnY2SYRgAYkHVRl7MMqfd+J/CShNgXoYusT8mEEYaQnd3vGFlhlUCBZR53ZVI/51xWvwbKDqKrp2KHu5E9B86pFyzKXphvJGDDnDytIzfUQ9pnMiMC5+DoomDj6o87lBP/FZQMDMtBQAxMnKBq/ePSG3Ui/DMdZ93qJe17XmQKnjFkQzzn9u3ZfJn/kyRh/eWE8o9RnjYxctC6Il7AUqrXHpM+jOTZKA2YCxHQ3f2IRpI+k5delRn6IB1/lay0u1u09POoGPrNvG/IXd1AEWN0eZ+Br1wIpNPSUtb1djrDK5FsJri4vKREX/NOssT3awW5CDZr4+f3II1t+ixUdtOXbxSjnr3UnzkRfFKxGrjJwahVHzxalwb7/ghgC3knKnQYsDJWvuL+Z7pzu82GoAg5L0Prv36Fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(186009)(451199024)(1800799009)(5660300002)(66946007)(41300700001)(66476007)(4326008)(66556008)(8676002)(8936002)(31686004)(316002)(36756003)(478600001)(6666004)(26005)(2616005)(6506007)(6486002)(53546011)(86362001)(83380400001)(2906002)(31696002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZUVndwY3NZRG1GZ0ZTN0FRV29VMEx1ZE95OWtsbFpCc2dMelFzZ1Bvc1FW?=
 =?utf-8?B?MDZic2NDajh1ZzFqNHcwWjBUaFhIR1JMTHN4cDdLVEJOTGxVV1ZCYmFPNFhr?=
 =?utf-8?B?M3JEdG1HemJUNGx1VzZ3aXRkRnZicHQ5eUs2dDZxc3F1azltRmdlQzVUTlk4?=
 =?utf-8?B?SDhobFJYWmFMYlZ1TllxeGpIY0lKZDAzNThjQWJQbytmOWR2S1hlQy9wbUw2?=
 =?utf-8?B?MEEvTUdZS1NnVlUxTjNTRUNmanFVU28vYTBZTERBTkNDV0pUTm1ERmJ2ZHdl?=
 =?utf-8?B?clhzWW9vSnQyMnRlZkFCTE1iQ3pvVFJwQ25acEtUWGovQjEyT2hSanJIbFFG?=
 =?utf-8?B?Uzh5NEJ4eWptSkgvSU1Oc3psdWtwSkFCb29oZ2ZZSVFXT0VtWGJDYXBlNXIr?=
 =?utf-8?B?SjNMeWZYRUt4N3pTUGtyL05NZ003ODdMMllrcUN6VUdlckFkVjcvRzFzOHNQ?=
 =?utf-8?B?cThWejA2aElVNTJIQUxvYTJsMWprSHZWUGZ0ZDdzVEt6NE9GU0lGMmpIQmdo?=
 =?utf-8?B?bVQ2RWxBR1ZMSGhBZ1BSVkphb3NwNW93N1g5bmh5aGVHb3duWExmUWhNRCtM?=
 =?utf-8?B?V3VjdkIrOElZNXRLVjl3N3JlZ1o2SkZMbWp2OGJycVN5VGxkNTMwWWVKNGk3?=
 =?utf-8?B?emVHZVhHS2U4dlQzcXFxMGY3VVdPTWk2MXpuVnlrRGpSUlNybHVpV1oxcFVD?=
 =?utf-8?B?QzZhZFlma0tjRUJGdnR0U1RDV3hISjN2Z3pCdzc1ajZHU2swbFIvN3ZLNEky?=
 =?utf-8?B?MGd6aWZwV25wQnVnZGtRYTFkcU1KdWl0UmNtSENuYTVTdkNDMXJ3Z3FxaTY5?=
 =?utf-8?B?TTFOYllNbTd4cE9rS0V3N05ha3h6Nmkwb3NBblM5UmNWOGdWbFlzUkZMS0Zu?=
 =?utf-8?B?clQ1NGZtY3FqbXBrbmlJbkU3dndGc1NyWTVNMVNOaTZ5N1RybWJlOCs1VUZx?=
 =?utf-8?B?KzNVNDhiSVRuNUxPVlF0VE5tKzNodnRaRTdWT3pEZ3I2ZGVvaVR6L0NpUnYv?=
 =?utf-8?B?TUJiRFZPam9WRk16d3JiWXdOczdIZU1mYklFVjcyd2lQb2RKWlpXSGNYbncx?=
 =?utf-8?B?YnNHaFd6K1pjZ2FQQzVuV29IVU03VzB0MGQ2ZXNzb1BGNFh3MHBXdmUrMnk0?=
 =?utf-8?B?NXBJeGs5MG9SZk43MHQ3TEFiNzlWMDhKTndub1VFZXZzMGF0TXVXRWtWZ2F4?=
 =?utf-8?B?QmxNSHljSDYyajF1TjE3M3ZLRDBEWkh6dnFZc1Jnci9nTUNwekx5VmFNT3I5?=
 =?utf-8?B?dVBEb2pmQzk5bnZVWFpuVmd2VUxLRHNNSEVyTzJhbCtGVGFuZWI4S1djenpo?=
 =?utf-8?B?eWg3bjRsTkxUMVhxNHhPSXFNR3pCa0c2MnUyUzU4VlB0V29NZjNRdXRTVXdq?=
 =?utf-8?B?K3o3TithOEhGTHl6WllUWGp0NXJ0MEVNa2RrcUtidjVYbVVDU2JDbiswTVhD?=
 =?utf-8?B?VzBVcXQxK2NYS1JTcXAxZ1RJL3M1bGdPeEl0alY5MEQ5VTVNQll1RXdBVUM3?=
 =?utf-8?B?ckwydWVma2hCN1VtU05Jdm8veGh2VFFuN2czaWVkQ21FeXJib0s1bUNEMDJm?=
 =?utf-8?B?a0c2Y3F4QUN5SGx4VEQ0QkNTOUlnN3V4aDRnQlVOQ2dGU20wdDNyM0tWZmhD?=
 =?utf-8?B?aUFCVGxlVW5MaklTRUdsU1BWYU8xZy9kaldFb0VMWWJBNTl6a0MxSE9ybGtp?=
 =?utf-8?B?UFU5UGtuTmlnYVEwWStMdWMzTWZIY0hYTW55VDdSckFkTTlJQU5ZNFVydkMw?=
 =?utf-8?B?L3RUdmcwekFDSDJvd0hPUXBjVUltMys5Sm82S1FNTjh3cEl6Y1FvNSt2VDln?=
 =?utf-8?B?RmlVb05YeXd1eWRrUG5oaDNtZm0zam9ZU1Z4djRSSDFqT2FCY2dlRmpDL1d0?=
 =?utf-8?B?NjRRbWNjNDN6QW5OVFh4bFZKVGdGUzZWUEpVZHhVVXIxc0FVeXBBT2puTlhY?=
 =?utf-8?B?T0RrVm9rNWFSOFpINStzNjhqV0c2WHRSSS9sN0VSNzhGM1l3QVhjMHhSU0tP?=
 =?utf-8?B?Mzg1WVJxaDBURTRvRmJxbVMrYWFjbDhidjc0R3F0czZIbWFPcUFySkxKaUhr?=
 =?utf-8?B?S3BJdUxpdGdTVkpzMHF3SmpDcDluNkcrRFRId0NGWVVHRURZdEgrK1BEOTdQ?=
 =?utf-8?Q?mnDDfzX+vSVlPWGXrHKS4BMh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f49a232-ed1c-4bac-7703-08dbb326a1d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 00:24:31.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64GV4RXvpxgkvwo4RK8fqCrNderadrrZtdVXuNQPbAQ2r3MmtIea/ENtjIeiwWxBHzXrxs7Ikp/l+Xvm72AWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/11/2023 3:22 PM, David Christensen wrote:
> 
> The function ionic_rx_fill() uses 16bit math when calculating the
> the number of pages required for an RX descriptor given an interface
> MTU setting. If the system PAGE_SIZE >= 64KB, the frag_len and
> remain_len values will always be 0, causing unnecessary scatter-
> gather elements to be assigned to the RX descriptor, up to the
> maximum number of scatter-gather elements per descriptor.
> 
> A similar change in ionic_rx_frags() is implemented for symmetry,
> but has not been observed as an issue since scatter-gather
> elements are not necessary for such larger page sizes.
> 
> Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>

The subject line prefix should have "net" in it to target the bug fix at 
the right tree.

> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 26798fc635db..56502bc80e01 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -182,8 +182,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>          struct device *dev = q->dev;
>          struct sk_buff *skb;
>          unsigned int i;
> -       u16 frag_len;
> -       u16 len;
> +       u32 frag_len;
> +       u32 len;
> 
>          stats = q_to_rx_stats(q);
> 
> @@ -207,7 +207,7 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>                          return NULL;
>                  }
> 
> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +               frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
>                  len -= frag_len;
> 
>                  dma_sync_single_for_cpu(dev,
> @@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
> 
>                  /* fill main descriptor - buf[0] */
>                  desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +               frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
>                  desc->len = cpu_to_le16(frag_len);

Hmm... using cpu_to_le16() on a 32-bit value looks suspect - it might 
get forced to 16-bit, but looks funky, and might not be as successful in 
a BigEndian environment.

Since the descriptor and sg_elem length fields are limited to 16-bit, 
there might need to have something that assures that the resulting 
lengths are never bigger than 64k - 1.


>                  remain_len -= frag_len;
>                  buf_info++;
> @@ -471,7 +471,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>                          }
> 
>                          sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -                       frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +                       frag_len = min_t(u32, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
>                          sg_elem->len = cpu_to_le16(frag_len);

ditto

>                          remain_len -= frag_len;
>                          buf_info++;
> --
> 2.39.1
> 




