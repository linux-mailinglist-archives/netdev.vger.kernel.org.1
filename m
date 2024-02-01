Return-Path: <netdev+bounces-68149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C93845EC1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771421C29855
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990BA74265;
	Thu,  1 Feb 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DDa12w/D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503374260
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809272; cv=fail; b=fXqNYCvKFRk0RHJZGEo0dzdNotG+bpgf9X1hbgGUZK5YRaeVjeOUFUT5jW4lAzeiq7dQh4SlePB600Xds/9Ywr/u9Fq74VkI1XuHYYfTT1E5Y2+KhuMDRVcvG+VJkS8Id4HYpB4eOXKxj3RTs8FiEv0s16fnUumeL57OGGg7abc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809272; c=relaxed/simple;
	bh=sfuSFNfPuq+l0ycc0owxeQyvJNgOghszcOLyTiuNjAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Md+Mb3utpbTvSa89m8gvYFkK9ma0FheTsZIjYdYuqFljhLURj8KIpU8QGtqrOt+v1rtH5eAW2WG3l/Sts3e6ik2IxiORrm0VE3OEHR48PIVotFAqcw+/24Lj9/l2Eotk1FSFzcNBSh8mGFPDUCAYxIDLxiH8PAU+Rw/A//5wAVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DDa12w/D; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu79a6vISSBYIFqc96rYZnerSpC1guQbf4PPIAo8CLJUKy6KEC+Ysh1/ZNvEtq0PLN1fybfy8j8uHTzbSx9PxSplifCifp7RUcGjSjmQsCp0F4ekQ8pymkH24iUtGA/DPpSgVdXgXFYybRpVAPWk2ED3rTPDEQX0FxUePN/ggti0Nnl1umsBuvFLIcVvhEKaCXCgnWltMulFUORukFP7XbTIq28bWVVY8dj5cTZhi2cvja6+c/Yf3XzWSD1BfRHspWiHdTamMwfqxDcenlrEJPuxmVYBHsc3s7DHURPS+93vGKj2FbqLfjafDQRBjLdDK+BUc/oUP9owz9FvV1f/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd8tvPctjUnE0J1f6m0ZTC3rSxynhMznFZA6BdJPNy4=;
 b=nZs2qeQQ+zzN/G+1UANO2mV8kwnCM7zpLogeW6niohyWgZUGGg28s+r3VY1NZVjFrC1R8mPwB8+yUfJwnz77QO0Qk1Wy/ita3QYURY+OHObe795RpHZ7sfoeCqPDtHpY5FtthP/T3OOcJHaIg/L09SCvKk8RaorDHIJNPX4sJMJ/4PctXgPpgtmYM/dKnME8VtR+K0xP+nzfGkdUG2FdhVcWF5oVGcHj3Xmp6H8XCczm2gYr3q1QI3ko/AytzA/RKyXiDIH/LtUfTBAcALUzKC9UI47km5T5aV4jcu/3g2qPlfhk70VVUiKzt9mtZOWowUQB/uoaPORwUm4kt9zs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd8tvPctjUnE0J1f6m0ZTC3rSxynhMznFZA6BdJPNy4=;
 b=DDa12w/DfKKGeijpkm2LmYibz3KuxjkNs+A238IqL29QIxU/s5elD0K6MRXeGF4cXDwDcnSRERY3tBYGzt65TEhTySPXkFzOkOfVnTrcO0QoVEmtr9rX5hoL7EzJWEE3sjKJW7/1c4vPyB+aCVdPqBBUiulnNZ0Rpj6eUluSN+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 17:41:07 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7249.017; Thu, 1 Feb 2024
 17:41:07 +0000
Message-ID: <e36a0838-8b0f-4240-9aa4-b031b4882507@amd.com>
Date: Thu, 1 Feb 2024 09:41:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] ionic: Add XDP_TX support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240130013042.11586-1-shannon.nelson@amd.com>
 <20240130013042.11586-7-shannon.nelson@amd.com>
 <20240131182505.67eeedd9@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240131182505.67eeedd9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: c638e5df-2417-4f5c-cece-08dc234cf841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TrQ7jsfBvaturP5ld+/SI32Ve6wrhADK5zSR+u9wcpy3pum9X5S9lbXIE5MUK0nuQieEm5NmxuxfdZE1kUSeSD6Urc75zD5l9mWpE8/EonH9oLLnI2a8VsrinOtoPmOyC2NuhmbhtjIJPWlmNrG9mhRSk5SfxtjptYVY8BMDtij6AZdZwJR4oxHVKBU2FrHsZkpRj4SMhfe+ErklK2PiRgfLSlRhiVdt+SkMYe2En0uSUP6JzW9Mbgq9ByX6iHbm57AcIK28158jtbCpKPIu3rMW7SHN7cUDXdDHspc0n3x4pimayiFNV0R74TGNoiVP9FahoRQYysG67Kul3G/tWwsM1+Ai9gID3YxMWCqipIEzEeHNjcWNYyVI0wwvX+OhUaayWTOcS/1+XtA6sbJfkYaobIPzRxA5OMKqmodbVVOGQNOK7fm91KsOA4UnJt2YiVvFCaYP5Dgr1R3nqHxyCWPJWitm0p34pbm/uqc8n/sfaHnlRmEOBCCLda41+0p7YGsAnvr+N3eLUXGJRQWNeamidHkTkUtYoIbVLimjTaP7Tt233sFY1HzoPxb8U1lWWSq4YZ8EyyCENn9NhLKqXDi+IMaINMGzlTmwNVWpE0HQdEQ/zzb9uGX4dFkrR+YHE5DSih0kK7e9Kh6/EhkkEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(4326008)(86362001)(5660300002)(8936002)(8676002)(6486002)(316002)(2906002)(31696002)(6916009)(66556008)(66476007)(66946007)(2616005)(38100700002)(53546011)(6666004)(6506007)(6512007)(478600001)(26005)(83380400001)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnM5VVh6NVRoa0x0ZC9TQjFZekdUTWhVUW4yWUN1RGZYdTRYY1NQbStkVDBr?=
 =?utf-8?B?SXBubWp4RE40V280UXVVaUFqeEdhT3pQZXFhK2dyejVKYnNlaERQRTR5a01y?=
 =?utf-8?B?TzhEQ1IzeXAwaU9PSUFLWTZUdmQ4bkQ0Ynl4N0d2TjVwY0RQOXZnc1g2dEVW?=
 =?utf-8?B?dm8yQUFkZGtqV2g4VXNoWWZhR3orNWZjckx0UUdjQkpWR0cvSG1ROExFd3h6?=
 =?utf-8?B?SGFLNlZEbEJjYVNyYnRpeXNnN1lXclE1YkozZFRWTkkxK2lUbS9QWDZEemFa?=
 =?utf-8?B?cmtvZXE0bGhobWpHOEdjKzVjU1VsZnl6NGMrK1dFaEZ2ZytDSHVGM1NtQ1ZS?=
 =?utf-8?B?QUpTMGQrSm4zMXVTZjhSUlNFMUtia0NmOHEvMHUzYWI4QUk1RWJBTVI2eUFM?=
 =?utf-8?B?SFBzTXBudjBMN0RhVjUwRDU1OUduVG5INU84UExqTDM2TWUybHdXN25LaDBo?=
 =?utf-8?B?YlNkbDVZcWVVNUtGK2ZOdTJBUVdxK3V3OFdNMHZIUXZFWlk4aFpyKzE2TG9Z?=
 =?utf-8?B?M2t6VnAyaVlsUXdWYmtxZkhnb2RmQm1sNnRMWDBTL1dTVGNmUHYxR2xRSlJY?=
 =?utf-8?B?dVJHNXlZQnZITk1hTlhXQ2NTWmRGOUtFQmVGRjk5bFdjclFaTTRMS2FOUWo3?=
 =?utf-8?B?M1kxcExtUHBCNC9WTjQ4VHNBRFk4OERCdjhQM2g2ejh4cUR5OGdLejVRc3dw?=
 =?utf-8?B?d2JCM3dKcm0yUG00c2dTczZBdU5Xem9GdTFkNVpkdExtdksyV2Q0Rnl0Z0s4?=
 =?utf-8?B?M25lRndGKzFZTEgvZDZlM05GVWlTR28wczIyQlNieU92QTNNMWI0alBZb2N2?=
 =?utf-8?B?ejU5NjZNdFYwaC9HRmRiU3g1MGc0TXJ3TjhrVWxOMWZxdUJZSmlQcmgycHNj?=
 =?utf-8?B?cVZDZGZZZ0Nsc2U0Ny9BdjZVY0MyNTU1NE9XSzUyTXpJQUNDaEhRL08vV2ty?=
 =?utf-8?B?Z014UkZIMThXZ0lmVTVSMVhtRVZIMnBhZFU2UFdkcnE5UjBvQS9QV1F2Nytr?=
 =?utf-8?B?ZkpmZGM4ZzFjLzJuWmgxZUs3UngvV1IzakFwQ1F3dDljSDg5K1lDTk13T2lG?=
 =?utf-8?B?NnJGNUlCaHlYN2JOS0RoSHhoZHBjb3lFditHamNEYXk4QjRnbFpiWGw0bjVZ?=
 =?utf-8?B?OTVndzBBdzAxbTJISjdERDJtVW5lNlZLWTFweVBNTnhDYTVJNWRrZlN0dU14?=
 =?utf-8?B?YVlKUjhNODg1c3Rtbm40bzZBTEl2d2NPNzZMV05RRmYrUXY4amtGUUtCeDli?=
 =?utf-8?B?eW9vY1ZwUnNnZWt1ZTZ5YTROSWxrVlllSU9LQnpaWDd4RWtXQkEwdE43UTVa?=
 =?utf-8?B?Ky9rYjJBUDdBUVUxS3BnWHk5M2RCb1pUMDVEYUcyUzVPVzhKY0JKSHlpUUZp?=
 =?utf-8?B?UGMwVitHaE0zOHl1d3haaHhESFVmMVhxdHMzeUoxMlNQbVlURTNIL2xWaGZ3?=
 =?utf-8?B?eXB6dTJHbUpIZlkvS1VGRWVMSFJrcU1Ud3VkUmc5VmJGVzkwRnFETXRVU21v?=
 =?utf-8?B?RlptUDBma0VoSWVpSHBwVDh2YXNyNEJocmxyZk91WkhmMFRQQ2IyMng5cTVw?=
 =?utf-8?B?RHlNYTZGL1BTc1BWTFpqNHljeGE2UW1YeGtQZkJZTGVzSWN4NTFzdkRrUUFt?=
 =?utf-8?B?d3VzZm9RUEo4N2RCMXBtdytXMTA3cHNEcFNZSjNuZGtOenFjWmZhOUxQbm9N?=
 =?utf-8?B?ZkpMblF0ajlSUTBqUjZEMi9DNTB1aGdSUDNSeHlLLzg3Y3dSSTRFNDIyRDlT?=
 =?utf-8?B?Ym9NdFhFSXVrRE13UTZYMFNLK3cyNkQwWk9ZZjdhNmd1cFN3K1NTVVNVRkpp?=
 =?utf-8?B?L28xcE4yU3IzektweTlBR1VadjljRTA5enN5a2haVWczNVVlZVVGQkY0TFVw?=
 =?utf-8?B?TmhOeWp5U3o2S1k3YUlLdnU0bldFVHJRNUllUHNwU1VQYmc2T29UY0kvN3FU?=
 =?utf-8?B?S0U0ekdUcXpiZEhXU05QcXBYZWNPcnN1cURIMDNyOFAvRW1sL28yQ3NjMGRv?=
 =?utf-8?B?R3BBQ2FaOUlrM2JqblFTY3hWZE56RUgvRDRwbzNKRjJiWXdtTU5oN3JRd0JU?=
 =?utf-8?B?TDRLS0FrazVGOVdMVFZVSEE4YlRvMXlOQlJIemZlQVNMa2tTbGxEc3VkaTVr?=
 =?utf-8?Q?uFv5XmxdcbKA7vOPDg15hqbt0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c638e5df-2417-4f5c-cece-08dc234cf841
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:41:07.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u37N1u8r/Ak4XykBZHp7CH8CETGz5jYKdtcLqEQH8taQGWmayIc9i7yav8mMks28ZrwSzEyGusHVO7ZFrMFv4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636

On 1/31/2024 6:25 PM, Jakub Kicinski wrote:
> 
> On Mon, 29 Jan 2024 17:30:39 -0800 Shannon Nelson wrote:
>>        case XDP_TX:
>> +             xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>> +             if (!xdpf)
>> +                     goto out_xdp_abort;
>> +
>> +             txq = rxq->partner;
>> +             nq = netdev_get_tx_queue(netdev, txq->index);
>> +             __netif_tx_lock(nq, smp_processor_id());
>> +
>> +             if (netif_tx_queue_stopped(nq) ||
>> +                 unlikely(ionic_maybe_stop_tx(txq, 1))) {
>> +                     __netif_tx_unlock(nq);
>> +                     goto out_xdp_abort;
>> +             }
>> +
>> +             dma_unmap_page(rxq->dev, buf_info->dma_addr,
>> +                            IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> +
>> +             err = ionic_xdp_post_frame(netdev, txq, xdpf, XDP_TX,
>> +                                        buf_info->page,
>> +                                        buf_info->page_offset,
>> +                                        true);
> 
> I think that you need txq_trans_cond_update() somewhere, otherwise
> if XDP starves stack Tx the stack will think the queue is stalled.

Thanks, I'll look into that.


> 
>> +             __netif_tx_unlock(nq);
>> +             if (err) {
>> +                     netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
>> +                     goto out_xdp_abort;
>> +             }
>> +             stats->xdp_tx++;
>> +
>> +             /* the Tx completion will free the buffers */
>> +             break;
>> +
>>        case XDP_ABORTED:
>>        default:
>> -             trace_xdp_exception(netdev, xdp_prog, xdp_action);
>> -             ionic_rx_page_free(rxq, buf_info);
>> -             stats->xdp_aborted++;
>> +             goto out_xdp_abort;
>>        }
>>
>> +     return true;
>> +
>> +out_xdp_abort:
>> +     trace_xdp_exception(netdev, xdp_prog, xdp_action);
>> +     ionic_rx_page_free(rxq, buf_info);
>> +     stats->xdp_aborted++;
>> +
>>        return true;
>>   }
>>
>> @@ -880,6 +1001,16 @@ static void ionic_tx_clean(struct ionic_queue *q,
>>        struct sk_buff *skb = cb_arg;
>>        u16 qi;
>>
>> +     if (desc_info->xdpf) {
>> +             ionic_xdp_tx_desc_clean(q->partner, desc_info);
>> +             stats->clean++;
>> +
>> +             if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)))
>> +                     netif_wake_subqueue(q->lif->netdev, q->index);
>> +
>> +             return;
>> +     }
> 
> You can't complete XDP if NAPI budget is 0, you may be in hard IRQ
> context if its netpoll calling :(

Right - I remember a mention of this a few weeks ago on some other 
driver.  I'll try to dig up the reference and adjust.

Thanks,
sln


> 

