Return-Path: <netdev+bounces-34132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524387A2400
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664A81C20936
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A7125B6;
	Fri, 15 Sep 2023 16:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A20E1094C
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:55:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4452126
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRSsEjouExx+BbEsv63WNSFoQ/w7oVfk3NEhx1+AhD69iSgSqgaqyB4vLpVQiXUWSdRHUIuQYpL1NEzKYKWuGyXwIqruWmW8tie0dCY2x9ai6sWFOj9MOhswVmoJBDxrRpottokqYi6+rPQsG8V9cVFa6sP0rLeN9kAh0t0ClVgYNW2n0M+pLErld9Pp3UXfq1fn5Zb9Resih9nk/yyn8cTjcijwJjpywWdzM6rEK/PFddsoUjVw1r+6UEu9KbQ5IXqkXFM1VPiaurdpBR9FQ7vnpoJMJHSczlYItCT/0MjDswXHW7c71hYZoRlL75FCCuo9GwH4yfvY+hIcx5s1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSfKtXY8oUturWf3q6PHWRBPmaiR6uja3l3esxRCw1E=;
 b=LXIj0Hqev2jbFHAHmR/G+iUMrVCc0nx7eY4C+IuQ6nw2aRrkSquP0V2RXH8Wa9019qGQ/u0uLerzoMT+9AI805MepuPBxa2L49RiEBbq8WbeUlT3hfzW/HSWsMNBDSeygBn+C2fBV3MBm3lasN94K0vN00nTNUQG9/9HVnN2v4K133IvDSPE+859voh2l59Y0T0ervpOKgwvOE0Tqkz9eNj5cgizzRQW15gLzw28AMaTKL1mdFKe6nHic13waLK3xbvntO4U+dC1y0gaNZv/U97mVYgixr90J4s19gj8VMdMjGikIaerO2END+y0ripD7Ammp3uU4E+eEicTz6mI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSfKtXY8oUturWf3q6PHWRBPmaiR6uja3l3esxRCw1E=;
 b=vPGDsgU6PzA0X7dHCqvc+JUqBqehf5CLG1tQW+Z+zG0+6CKp2bLLJ60OOiTrtS9Lakc2SdBuzQW/XMMu9hEjEBfTGyJ2vHOHDVQzEGihLwpOQWmCUPvkMdpF+6cR16qt9Qu1XPHCHPhZFW7er7Mt2V/pD7wm17JG/AjJSE9riBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 16:55:50 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 16:55:50 +0000
Message-ID: <96eecedf-a7af-4a66-8377-bb411adf7919@amd.com>
Date: Fri, 15 Sep 2023 09:55:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
Content-Language: en-US
To: David Christensen <drc@ibm.com>, brett.creeley@amd.com,
 drivers@pensando.io
Cc: netdev@vger.kernel.org, David Christensen <drc@linux.vnet.ibm.com>
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <20230914220252.286248-1-drc@ibm.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230914220252.286248-1-drc@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 645e2c8c-9445-442c-56d3-08dbb60c9d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	96AHSmDc7BxBJFrVOAlLTLPRPwB/PtRpTxxqifS6lQJndhqnkf0M8VBTbP3vuxwgHvgj9OOf1fYcEzV3XOiAK67oCF5uSSSdVwYTn7Nq179X6Jrf9LROWoPT2XCvBmqZDP/zAUtg87X388T+DEE804h5XugQbyAQtdGIszjl5O9ES4kc4/My/j9QhB43xov0/vLhtCbokf4ANhkES3E19TmTEr0e7JUt3Fd4IkVhsiLJIy7Vch26cK8uF4znH1Jef0PgNIEwz0VrJzeFj6YMWJFj9Yw7gus30Ryn7jhCW+fCp2FVgt963TZ+V7vGchkcKNp6xgoO3ECCIo62whETfJFYctFM/HM5mDczrdmoKUMY06hARpdIc1MECPkO7EfN9a0HiN2n5o3oZ3xaD+7G369ebQmOfT2OAi9IQLZI3sEVGUtTUDxFp7QjR8YRqnIDIwH/xxPZ8LLKxrsmjmrv5d2XkaPLw8VoA5NncWgqSiFRYPo78SAVX1k1jeSBjo8WlvlTFj4QxUIjQ3YGw2JvUwYPHBzFkMa0EzjIoS1gVBY1MDJW2xNjPB6LjtAB3qWx/dYTEq5gGtD10hvyUWEALlAuSHKXY0nMPBGgiFtel9MO8aiAMKRb+6IPHTP6XtG2DpxyL+uYLhCawk7bIn7sJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(1800799009)(451199024)(186009)(26005)(2616005)(478600001)(6512007)(53546011)(6506007)(6486002)(2906002)(6666004)(31696002)(5660300002)(8936002)(4326008)(36756003)(66946007)(86362001)(66556008)(66476007)(316002)(41300700001)(31686004)(83380400001)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alBadXlOVkh2U2xaVnNlMzR3VWxWMnNURktDY2Q2bHE2VHpZSzBJd0I2WU9Y?=
 =?utf-8?B?ZFFtMU1EbEJqNkVUTDJDSVlKVlRXTGYvaFpiOU1vQmxWSDhRbDZqVk9EQUdP?=
 =?utf-8?B?SUc0NU1tckNrVm5xWUh3MjJEdWgwODF6dExlYU4rVW9uc1drdU13YXdETktH?=
 =?utf-8?B?N0dab3hPRnN6M0R2bzhXVVN6bTdDUy9oNU5DUlFZUWxSOVZPd00wV1piZ3hL?=
 =?utf-8?B?bC9laldGejVKQllET293QXJMd0Iyamo3SnZET1V5ZlB6SHc3UHlHaE12YzNq?=
 =?utf-8?B?cnZOamhhQng4S3Y0TVpLcWVhNnJxdlQ0ZVdiRzRCTjBSOFpQZS84dk1mZUJJ?=
 =?utf-8?B?QUlJaXpheGh2VldIMk9GUlN3SDZUU2NmL0JDdmZNUVVnZXJUdmszRFZ2azM4?=
 =?utf-8?B?V3AyOVNtekZyaGpSU1RyUjJqMUZoMU9HVXNzTjVaNkFCRXZ3QzBzaDRCUEkw?=
 =?utf-8?B?bnNod0kzQVYxeEZSZUIzZjhDQ2Q2b2cveStDK0hPVmFTamk2TGxrSFZsNisy?=
 =?utf-8?B?T2ROUksyaGYxaXh3bkw1V2l2Q3NBem1VRU5rN25CSXZvOGNhZExqZ0VBUWs1?=
 =?utf-8?B?cGptSVAxMWtoZ0s1ZERia1o2T0ZCb3F2MUtpeHdjVG9OREdFRkNYNHdWT21j?=
 =?utf-8?B?b2QyV2FvVGZjRHNpZTFta1hnK2JiZ3VLdkoyQ3VFcWI0dU5aZkcrSkdseit0?=
 =?utf-8?B?QnhhUGJ5V3BHQXo2TGtNS3NnOWVpb29ocFphdWFsQ2xtaTBDdC9tSGdzNmh5?=
 =?utf-8?B?TEVKanZTdmZVZUZJTnpPandpNXpwajg1UFFZZWYwemRRbHM3bzluMnhQUDJE?=
 =?utf-8?B?QW1YN3VXcFRQMVRlYldSYVdJemJoVWNOcVM4enU0a2JlOGllMmtOeGFYOXAz?=
 =?utf-8?B?dkxLNkkvYS9scFdMODN1MTV6TjJaWmdNaEEyRDRFN0RGVTVlYTdZaDZMbFd2?=
 =?utf-8?B?Wk9ham0xQnZmNkJyMzNKZ2I5WnZGWnpBcytDVDZjQWF5VWlyVURlVWtydGJo?=
 =?utf-8?B?Y2FYRzFmeXdGUWUyWEFOb0ZUZ29KU01yMmZ5NFZBcENTT2JhSGFEY0NSdEZR?=
 =?utf-8?B?eEFISzVScU1SRTloYndvdEVHV2tzVmd1czlDR0pES1dJcDdjQ1grZWZOcDlS?=
 =?utf-8?B?Nk92dnhiRkJXQ3YzcTlRN01SbXorOEwvckI1SWZjNGtoanpPdkNIeCs1MG1k?=
 =?utf-8?B?K01QbFVjVmhvSW54R0g1d0NHcWFZMC82UnNaVkZRWXlCRnhLbHBySXdBRFdy?=
 =?utf-8?B?R3V0WXJ3MEJsMUkxdG1sVFM4M0FST3NDQkhmd2xRakllZXdKZHhDSHNRR2p0?=
 =?utf-8?B?OW82b0UzcytuYy9TYWsrNFhiSnpwMVJ5MkRIY1hOSGJ3QThXSENkMXFuTDQx?=
 =?utf-8?B?TmgzK2czMXVJZGFmQmN0cUh2ZGdUV0x4UVVnMGxheWFMT3krNTEveUxEeVFr?=
 =?utf-8?B?MzRkeExiNUFpckhSNXMzb2MrZmkvcVNSNW44bDd5TStvUWJoU3ZheEVmSFZY?=
 =?utf-8?B?V3lUamo0R3h1WU9rS3Q2RjViWWI5VVR3K1EzMmx3bmsvaXQzS2NndFQwdE9I?=
 =?utf-8?B?d3JZa2hxbHh0L2Y3V3o3Yit6dlRNcHVhNGtUaGpNZldDbGViTlFKRkhsSWU5?=
 =?utf-8?B?Q3g0U1k1cnNMVDkyYWhHRzV5OXlRV0o2SitlWXEyZUhIKytaa1dQSEsraFhT?=
 =?utf-8?B?RnQzL3JrV293cDg4M3AzSUNoRGJQbUlieGpuVnJ2ZzBDZEFFR0JvQllHOHpv?=
 =?utf-8?B?TTc1MFhDL2VnVFVHNTIxY3hsVlNvNjIzVnNCTG5IVTZqbGFOWFR4Vkl0bnNt?=
 =?utf-8?B?SlNlVExBTVRPTGJYZ1NBY0c4cDNMa0hzVlR5cjBuL2kyVmcrZUtmcTV3ZHBC?=
 =?utf-8?B?WHBlSjcxNlZGSnEreFVGd3JZY2M1M0VocDMrT2hlUktOcXpCZUgzVkJPSGE4?=
 =?utf-8?B?Um1DQU8rVkJ0UG9vTlJQTnh3d3JJbTVpRUtCNEdYZFFMTXBselZUR3FlMWZt?=
 =?utf-8?B?RzRUeGtkdE4wa0xHb0FGSGtUNGVHS0I3cjgydWZOT0RiK0xGNDBBbVdKNVhw?=
 =?utf-8?B?VHdCOUI3S1dlTWgrcDRGYVd4WitQZEg2eis3ckF5eUtMMGVoZFltTmVFWllm?=
 =?utf-8?Q?m9iE9twE6Vhej+B8ZcAq4tG1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645e2c8c-9445-442c-56d3-08dbb60c9d5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:55:50.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHVILPEvKPYsES2bjQjytZNLDDff4fa12yZlw7YfhaHQBZyOkxDapF10FlXp/vFk2X55uIOUMpgq0zANVUQ72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/14/2023 3:02 PM, David Christensen wrote:
> 
> From: David Christensen <drc@linux.vnet.ibm.com>
> 
> The ionic device supports a maximum buffer length of 16 bits (see
> ionic_rxq_desc or ionic_rxq_sg_elem).  When adding new buffers to
> the receive rings, the function ionic_rx_fill() uses 16bit math when
> calculating the number of pages to allocate for an RX descriptor,
> given the interface's MTU setting. If the system PAGE_SIZE >= 64KB,
> and the buf_info->page_offset is 0, the remain_len value will never
> decrement from the original MTU value and the frag_len value will
> always be 0, causing additional pages to be allocated as scatter-
> gather elements unnecessarily.
> 
> A similar math issue exists in ionic_rx_frags(), but no failures
> have been observed here since a 64KB page should not normally
> require any scatter-gather elements at any legal Ethernet MTU size.
> 
> Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>

Thanks

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/pensando/ionic/ionic_dev.h  |  1 +
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> index 6aac98bcb9f4..aae4131f146a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> @@ -187,6 +187,7 @@ typedef void (*ionic_desc_cb)(struct ionic_queue *q,
>                                struct ionic_desc_info *desc_info,
>                                struct ionic_cq_info *cq_info, void *cb_arg);
> 
> +#define IONIC_MAX_BUF_LEN                      ((u16)-1)
>   #define IONIC_PAGE_SIZE                                PAGE_SIZE
>   #define IONIC_PAGE_SPLIT_SZ                    (PAGE_SIZE / 2)
>   #define IONIC_PAGE_GFP_MASK                    (GFP_ATOMIC | __GFP_NOWARN |\
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 26798fc635db..44466e8c5d77 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -207,7 +207,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
>                          return NULL;
>                  }
> 
> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +               frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
> +                                                IONIC_PAGE_SIZE - buf_info->page_offset));
>                  len -= frag_len;
> 
>                  dma_sync_single_for_cpu(dev,
> @@ -452,7 +453,8 @@ void ionic_rx_fill(struct ionic_queue *q)
> 
>                  /* fill main descriptor - buf[0] */
>                  desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +               frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
> +                                                IONIC_PAGE_SIZE - buf_info->page_offset));
>                  desc->len = cpu_to_le16(frag_len);
>                  remain_len -= frag_len;
>                  buf_info++;
> @@ -471,7 +473,9 @@ void ionic_rx_fill(struct ionic_queue *q)
>                          }
> 
>                          sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
> -                       frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
> +                       frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
> +                                                               IONIC_PAGE_SIZE -
> +                                                               buf_info->page_offset));
>                          sg_elem->len = cpu_to_le16(frag_len);
>                          remain_len -= frag_len;
>                          buf_info++;
> --
> 2.39.1
> 

