Return-Path: <netdev+bounces-86749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D08A025F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E87281C5F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89D1836EF;
	Wed, 10 Apr 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YrmTLD6W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EF1E877
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785948; cv=fail; b=d24xYy2AB9buZZIcsi5xWnNs4rksxp4WVC66EaDwSZfi1eEO+ZymtX2GL8l5bczU5yREMahbns03aNeRSTpiGzflR9j7i1Z6X0fXT3xgpkPbisVXzj23TpCU5jnauZjSpB/fCNDPKFdlr+B0VovMgWlmBA61OxTtKfoLrF5DQzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785948; c=relaxed/simple;
	bh=Vn3QQqeP/f8HvU2NAKDqzZnQVXhpaiUqB1vAsSzQ03U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfsvVEFrVyYU2xTMfKxMxkd4XqWr2GB9lUoaIqazht5G7yzWoQO6kHBr2r+nMai9IiMgoWhRIFHd5qqP9h5f55L8zzH8KM2bLoAfLN722unuUzkMf5MNwhVY4PKvGDn582TGipwzO7R1vsRpiJZWRD4suc73jFQ9KMkKikl3ZTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YrmTLD6W; arc=fail smtp.client-ip=40.107.237.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJbx5Ce7MjFuNNDLAhQRZPzKXF2hCNpucOC7eWfXFGoVlnp+mrSHPwtwdr+Qscd379XSr5iwJDoU9RfkWT4kzAzpTN9lN3iUAasBgnC8GRA4iJodx0+ckBCZsepnk+8c57BTrxBDHTRLhwnjGwMlT+5W2Kp9EkqsFUvzvwVZ4Ua1jx8nbUMFPZnzJIjzD3LerBmNFUmVKi8bcd0qcJ6Qw+V5nasJBYNoqsknOUlVPhgRBOoXFHzbsD6Q4M/OaJ5+FM9fTC2knkxg+6FP3pVpYVBIYIayqivoJtThEmsFl/dkLux5SZfyx/6Ehvu5ILGUm2Wknnw7kefIlYWRFp52tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Gh8F66EhFMznpYDPeQ5Pcd3FGWUW8/4De4Mwzuayg=;
 b=G0BqDFn11hu/DZjo3RM0l7urgLL9k774yFduO7jcv0Uqny0XtVaRkGq3BAR9kp3dbz11snOq3KELPG47QJMI9zHVwd+7FiyMJ+lYveKrHt7O9Yjtne8XoLVhyyoP2a42iVUXFosz0DwA5Quc1ZOdtH0VWB1EOm1Ngu+VieFEmy1vqNv5+kLOg/AaLUVYeli6ZpYt0VlEQX7jwn8ZdLq/5uO7yoNmVop6zb3FTS2CuiY4KRCCI6UZAEcSj0hM8vesDGBucmZjXVktkSeieWrvqOMGk1giqIUh17as9Lg3bDAK2/elFYgk94grr97AHGbG5h62oSWNPjKBQyyBxRdxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Gh8F66EhFMznpYDPeQ5Pcd3FGWUW8/4De4Mwzuayg=;
 b=YrmTLD6WiW6SgYY2IYu4GUyIdRU5rWL3BB4RlVhZi8dCdsq1N1mKG8QdjMilgwRcxdK0bO/ZAqBBNgN3paMBQtZ+oE9k3abJGFV/fYsHBrwCNOZV4lWfhzIs2Df5t1518CYGRsAHpIyc6vh+FcJBSOC46dXSZwMtR2/OI6k53vU=
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:52:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 21:52:21 +0000
Message-ID: <65a68ce7-9be3-46c0-b33a-adf5c9796bc8@amd.com>
Date: Wed, 10 Apr 2024 14:52:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 3/4] net: ena: Fix incorrect descriptor free
 behavior
Content-Language: en-US
To: darinzon@amazon.com, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, Netanel Belgazal <netanel@annapurnalabs.com>,
 Sameeh Jubran <sameehj@amazon.com>
References: <20240410091358.16289-1-darinzon@amazon.com>
 <20240410091358.16289-4-darinzon@amazon.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240410091358.16289-4-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB8089:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VzkQWto8ERC0Nq1FfQOdwys4lyeBj0mB5t3+sJPci6MA7e7s/M7HhlxuMC2kqbKzALJb8FBepa3Wspr9M1PleoXpQZDXGfB3ORSuMAucb+BDecKxb9DaQqgm7upEt2ZD+5pS/hR58ecxAGoTGZPml7yXzKL1HIkU7ZinLKukPNOOhmeZ4umh3yMLaz0jIYKZcAod8asf3UpUmvf8HZ2m5DUKMeIm1HTsM/fkbxq345p7rXWCVbNLIwsHeEG6x2POBTUMUP8essE73FW0/5EGkN6lh3sdLByxleMsubwESfCt+zVuK+whpaEfm0BSfIt+cKA+/8e/6jraBEbjVjLdZnAA2r01gvB0QwbUmYgtrgQWNeBZeuTrvfqLkNlCzz9tj9tqufIL2dmh+nZsgxHsu/uqU3QoeLLxd3kADwZeG42pmwwtT4EVAGH2huwwkkns8vuSVzhCssnk9r48HI9WA8nUOsa1J9rmjgOqdxfbDbYuKRhUM84xebTNmTgw1TgiAS44HchuT363LM/UsShNQgHyGKyXfB37YpV3dRWYnyVX9eG92MfmrCbCIinRxPjRoR6FiWnYpPPELYA1Lpi8q8sYMhckoJMppSvJwFzqPh/D7x8f1qWu4KwoiAQI0tG7qG+yju2q59GsATJ1816sTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2JNN1VDa3VUV0RIemtVYTA2N3JlSnZ5ODkwZEVCVnNTYkF3c1ljWmo1UW1k?=
 =?utf-8?B?SStRUjB2U05JNC9JZk0xK3c5bmQwVUNDSE8rblM1ZHVqZDA0bllUVWduUTZH?=
 =?utf-8?B?RFh6SUhGK1c0YUxtRXBiNVU4bFFCM3ZNR0lHc01ML1dRQVJxNjhET2xKeExE?=
 =?utf-8?B?R0x4QkhGc1l1Ym11SmNpZWlxUzd5dzVXMlprMHpaYjNlNk42OWxYRVZWdXk5?=
 =?utf-8?B?aHZwUlFURDZaWkdHb2RzZlJQRnVYVG40Y3BzeUJQTkV2R2xUZ0J4aWJsYWFI?=
 =?utf-8?B?UGxJR3dCM3M5OFQwNmlKVEhhZ0FNZWp6YktRMDNXWGI5VThWUXRhZERTWjRJ?=
 =?utf-8?B?U3FTRlpjWG1zaG1vWWNtRzE1Zjc5V3hGK280NFE4bTNhWUtNSjRma21rdzRm?=
 =?utf-8?B?RkJkRE9FWndqNjBnM3I1T2IyNFhpVm85dFBaZEpVOVAxdXhmWWZHeXNXRnZI?=
 =?utf-8?B?bU9mMEdPRzBjL2JDMnhRZTdlVVllZWlTWnhCbENSd01HRm8yS1c5Q0M3WHNz?=
 =?utf-8?B?dWlXbi9DRjVoY08rZWh4LzhsQ0NPZzMwZHVPczlrMkg2TW5UODR6eGZ6VFdk?=
 =?utf-8?B?a05XWnB3TGlxRzB2VExQbDZwZHNQZHdpQ1BnR2VJM0NPL1EzdjJEdUNFUGJW?=
 =?utf-8?B?UUJBZC9xM0ZCTENOUjBJV0tzOERxdG1yWm8vMFpUaTViRU5VNkk4MXNZZmxt?=
 =?utf-8?B?T2pnV1FpQ2dSQWdNK28ybG5TUC9FRjEvWjBhNVVVdzJVbWFTZzRpek92YXFW?=
 =?utf-8?B?TTVvUGJRMm1tNjYrczc5bXRzTy8rNlBFVEVPRTR6V2pGNHZlVlNJWGd3SDJI?=
 =?utf-8?B?b0FFWWtwYmxZclBlZURxWis5UjNiNytBU3pxUnV1cEI0NUR4bVljUG5MM1cw?=
 =?utf-8?B?cFkrVE1mUlJDTHFXVW5kQVdpSGxtS0JTVFMzWmZKSzhmT2s4QmkwMHNxZ0d2?=
 =?utf-8?B?Q3lUTk9VZW92bXEyK1JxMFBocEtPOFBZcFdYNHZZeDRhbW5ySVYzOVdWV1pq?=
 =?utf-8?B?Ui95Sk9YZmVkR0Rib3Z0bmtwL2JkWCsyUGZ5d0IzWXZvakJGZW1RYU83cVVi?=
 =?utf-8?B?MFQ3TVRXR0xHMG9jSjZNOGlxbTcxWXNSa21QbkhaMWlQZitWRmpydXZwZ296?=
 =?utf-8?B?OXR3c3liU2crMm9RWjhlbkRuWWdraWt5UUpmemlaalh4WXRWUDc0Z3RaN3h5?=
 =?utf-8?B?Rmo0bGU2Y3V5c2doMjlUekdtaEFEWmxIclJTaUZGTGZPT01RQ0hpQWpWUWxi?=
 =?utf-8?B?bGlRM1IwbW04bGRBR2t2ZFVOckdlN01UbTZ4b3FJdmdkY3k4YzduSitnTW5I?=
 =?utf-8?B?OWRGT0RCVU0yRFd3WXprUTZ4NWR2WlhnWVFGVXIwOFo0RExnam03c25qS0hJ?=
 =?utf-8?B?N2R1UndYam05YnpqSEpoQWtNakx2dlJOcUs3c1BNaHJEajhQTXhnOFFaQ2ZW?=
 =?utf-8?B?bHJtWWdMRTF6UEVsQ05xbENLOEQ3RFZ5czY1U3VKQjFLakJFYWJKVTlCZUp5?=
 =?utf-8?B?OVIrc3ZSbC80ZEQxcHEwbWRaYkhyVTRYR2g0QnpoVEpiWHhTRkFxZmZ2SDQx?=
 =?utf-8?B?ekNUcUs4SDZEL01ac2Y2K2YzS0VOc3JaQjdLK2F5SEpMV0hrbndyMUZmU3Zh?=
 =?utf-8?B?eEZLRG8rcnpTRkdHV3pRMkJ6Z2h2NEJxWllITFRpSlZCZHJUU0FFRllwbFI2?=
 =?utf-8?B?M3RueTcveTlHUGtPMFhqbXR2WVY4cVNxZjllTXEvS2hVb0ZlSXdTaVI0MmlZ?=
 =?utf-8?B?WVAyVVJsenpoWG5lWTF1bGlQQ29aNjJKbHhPMmwvNC9oUEs5RHdSVUhMUy9v?=
 =?utf-8?B?aWtBRU80aUpNeTBWcElEWk5HWmhNWVhaajJraEtHMlhjL29mTWxpWG1YKzBx?=
 =?utf-8?B?WGlGODFkTnUva0VoQVpWWklsSHlnSnBpS0lsYTBuSDhQazNRZEE2WFNOc0w4?=
 =?utf-8?B?QXRUNEpJOW9hZjBGcitidG5kRk1KUktqRHB6Skl2anFHL3I4VUV4czlKeW1p?=
 =?utf-8?B?MXZsUGlhYlJ6cG1hd3JUbG5xandtM2doM1NreXQrWkRQeE42OFNkb1BZNG96?=
 =?utf-8?B?NVlhQS9sQUtqUURNcXpkbTRqdms1T0ZkUnVHbktSMkduM0NpSFRjTC9LUXEv?=
 =?utf-8?Q?N4W6mJW0o7GAo/4Ij6kXKuR28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba52ff99-5551-4131-5334-08dc59a87fa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:52:21.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlWHgabARvHSeH1VLdw6LvZUS5RzCZkARP9pse/B4vZD42pIumYKh4otx/6rEDNExHCyytkkSTUWWW2orJhytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089

On 4/10/2024 2:13 AM, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> ENA has two types of TX queues:
> - queues which only process TX packets arriving from the network stack
> - queues which only process TX packets forwarded to it by XDP_REDIRECT
>    or XDP_TX instructions
> 
> The ena_free_tx_bufs() cycles through all descriptors in a TX queue
> and unmaps + frees every descriptor that hasn't been acknowledged yet
> by the device (uncompleted TX transactions).
> The function assumes that the processed TX queue is necessarily from
> the first category listed above and ends up using napi_consume_skb()
> for descriptors belonging to an XDP specific queue.
> 
> This patch solves a bug in which, in case of a VF reset, the
> descriptors aren't freed correctly, leading to crashes.
> 
> Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>


Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   drivers/net/ethernet/amazon/ena/ena_netdev.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 59befc0f..be5acfa4 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -718,8 +718,11 @@ void ena_unmap_tx_buff(struct ena_ring *tx_ring,
>   static void ena_free_tx_bufs(struct ena_ring *tx_ring)
>   {
>          bool print_once = true;
> +       bool is_xdp_ring;
>          u32 i;
> 
> +       is_xdp_ring = ENA_IS_XDP_INDEX(tx_ring->adapter, tx_ring->qid);
> +
>          for (i = 0; i < tx_ring->ring_size; i++) {
>                  struct ena_tx_buffer *tx_info = &tx_ring->tx_buffer_info[i];
> 
> @@ -739,10 +742,15 @@ static void ena_free_tx_bufs(struct ena_ring *tx_ring)
> 
>                  ena_unmap_tx_buff(tx_ring, tx_info);
> 
> -               dev_kfree_skb_any(tx_info->skb);
> +               if (is_xdp_ring)
> +                       xdp_return_frame(tx_info->xdpf);
> +               else
> +                       dev_kfree_skb_any(tx_info->skb);
>          }
> -       netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
> -                                                 tx_ring->qid));
> +
> +       if (!is_xdp_ring)
> +               netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
> +                                                         tx_ring->qid));
>   }
> 
>   static void ena_free_all_tx_bufs(struct ena_adapter *adapter)
> --
> 2.40.1
> 
> 

