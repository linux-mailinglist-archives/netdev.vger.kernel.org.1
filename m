Return-Path: <netdev+bounces-86750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A98A0264
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BD21F23D2B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5607918412C;
	Wed, 10 Apr 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aC0yjdWK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3A184121
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785989; cv=fail; b=jDTXjSxZySQy+1PMddSOa82Lef5WxwCdnGe4PJiKdHceuJYYcn43R+WGQ7ARCMcUd04XGZD2B/6+JrpRQ5Y865fnwpfX6wvW2PDXEIQbkwSMJNwnAauPVi9DNqBVadOFlyku+r+qZ0HhaofY3MW/SKin/+gb5PWYZJso7gk7Vlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785989; c=relaxed/simple;
	bh=L36/jf9liazzDqcVgHeGKx+fG+6m8oMMHbnDj7t/lbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYjodcSXuzELynS1C5iQwaBsPwwOMqpwsSxZlbe6LHLIJGRNQHYt3Ibo+Hl0LX8DMPj7Thbo6kGl80oBEYuZoRcvjISJ6UU0fMDmO10qI6rFRKES/V8fDIwyP0DW6n0/NDHaAAwmrJCyvKDcc7iQF1LwrEtv6xcQ/wAhLHWLEcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aC0yjdWK; arc=fail smtp.client-ip=40.107.220.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNxObb/6r9swvgqijzLymzQO4I1WFfecnWOAnZHQs/kRaxMYuse2RuDYt414MDQQPDrtJyILx5nCKMkf6lj8NM3fOsz9bH5ZZx1bn1KukeKGLa/EaW46fEuiq5jvATN/pJvUJertmZo0j0xq11oKpPq3x3EpOCBA7yVx3Bj3bLPf+zBWIBgvNKYQBiLotFVOfSP05+/HnlzLnfnNPXM8l5S4M78Sng7P9p2Ii+qojI7nhtS+esuiW2HhUjqUASh6UyrOTGWlpw/GhKXpxHUsyTkw3gUOGDerjnh82PDZIal4rZ1wpfFmPFElKBsYhdh6dorJ/DPFAK64NwJXh+1T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k81pR/AvXB1lnbUFOHlNKfJfpoNuqx0YPgD146cmeZI=;
 b=RrM+9PvOXs52IblToGq80q8gfg1mzIh9GEhNrxLM04Vq04ZxMNr7GUw8u6GZ4lqhBJtg57I9Rvql83pGhiyb+8IQKnYgGH1wjLFXfnc+IG6GB1EEBT3Kxfrs8+wAGSbeuKNCsBI6mFTcHXghcbwiJ8xS4xa9vExZRHiX3+GXPtEHEXWyA6zyZdvNGAXqhvGBw2YFAELQsb48sn9YHd/Afh8tUgqDvsfH8aP2mPYQxAm23mJBa/J+HLEt6XqLOmMQSrYsEvRGLvIsuJVfMbQINVJfUE3EtlqY6UQrGCUNeK25/LYaqZou/YqaLtzwyG1NSYw66xP3IkFVFzYQ3XEjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k81pR/AvXB1lnbUFOHlNKfJfpoNuqx0YPgD146cmeZI=;
 b=aC0yjdWKo6p8brRB482Z5bJo4yEU4+qhxTub5iWjOVoz7ER36Sz7w7ZekmuiRiM8529s3tRNaG2WtU1U36GV86g3/agETWA35KQtAiG1CHQsy6Ac8DwOA1YjynSoKXDDDQ3vIL1nM21Y07KaLb3PwA5TWhzTKIPOScukOK2cy4A=
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 10 Apr 2024 21:53:03 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 21:53:03 +0000
Message-ID: <860d573e-09db-47b7-a9bf-8b915fef6a11@amd.com>
Date: Wed, 10 Apr 2024 14:53:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 4/4] net: ena: Set tx_info->xdpf value to NULL
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
 <20240410091358.16289-5-darinzon@amazon.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240410091358.16289-5-darinzon@amazon.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS7PR12MB5864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AbrrJbCxHx5Mfkwn8Ozf9vEqBmkKP/mfFIIeo0e1Ma5/zE5GI9lN+ddPOQ0wIth6g4Z7j/yjB/9zJOd8tRAUxCbE9Ot9QbAsa/u82CDQAS674szUKtw/0sB8Z7EuakJQl6YHn6LKM2xopwaR4yht3CAZqWD6QCJMqth5OiTUoV9JVr5NhINgmXjCXGPfKFMe3fc/oqGNlMo7tJ9bxe61GQfj56wEnfCPsVhQqjgpaHMLU1X/n7l0lB0JypawV8ivykbgJsLNp6mYbn/Wg26huHELtt4WFZd16Aag/1ki74nOYxDYZOnIwt9LyZIDorWuWPzYkB33HIug3rwN3E44EgSYZpM5id5Aiy4nmBQ5XYe4kO7OTqS+GNcDeBpUFjFvWVGq2KohE9hf03b3PqKirD7s1Vqy+ElrKV5foeADsyywqoJs2VfQc7r3vAJ7CdIzlYor/0t054E4ny6tA5wsx7HXEQAzHO7ZIcNpIOgTgBK8jr68gmbl6GkO7AU0axiYbRmZoOcB4cgXj2czvPq4vnr1xM/0PCdkEB7pVL5ZCFj/ytKR1vL82lOjLN+jtOnT3uwHp9MIxmzkcNuH01XT47eqhtYJMn/tMeRCGMCEZNRGjrH0080Ybam4O4MvBBqxGDaxBCm0OFsaKoCx+NyrIOdIUpKbggb5LNpUc+M+LWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlExR0d2ZmUzemZpQ3F3c1AwRkd4SG9HckdKUnZUTkttRDhzUG8vSVVVeUZr?=
 =?utf-8?B?dWdrZHBLc2lQR3hSZXV6UWI1VC8vTFNmU2tTdnNDRVo4b2pKbmVBSTYrV1FG?=
 =?utf-8?B?Yzh3dXF1aXh3bzJLQkx2NWg4d3I0YmhWZTFxQi9OZWJId012UTlrMzNEZWY0?=
 =?utf-8?B?dVBNQUZvRXF0NVZFVmx3ZlZDUmlDSFErZ0wxZkYwcHFNZHBXSEFQUUVaMC9l?=
 =?utf-8?B?VXVpSmpIbVdUMEp1VG5ic1ZqdWp1QkVjMDA5SjdSL0U5MVNXL1pxazQxUjlx?=
 =?utf-8?B?b0Z4dmRPUEVIaWlKNzZiNHFwc3cwTEtpQVAvcEltWGFZMHJyZmFGR2NtZDM4?=
 =?utf-8?B?WVk5ZlNua3VtTCthajFiaWFwUWN0U2pMcEVRM09rRm1ZOTdNcmppWUh0SnFw?=
 =?utf-8?B?eUJRMG5OWlJHOWFoN29SNGhVRmIwSE5ZZ1ErUUpMSGNiaEdkWUtZUVg4WTdQ?=
 =?utf-8?B?enNPYWRzWDhUNGEwZWQ4S2JNWlB1TzF6aTZyNmdlQ2VWZFphSFNCNWFTOHNt?=
 =?utf-8?B?K20xdzBHdXM2cXdoaG9ZY1lzQ25PeTJNRjQ5TUxtUjV4L0UrTGR1WVRtaWxO?=
 =?utf-8?B?YVhlRFFxaTJONHN1T1FoTkx1bUd5NGVWTlkvaDduNzVhMkcyb3JFdTJ4d29P?=
 =?utf-8?B?VDdtWGk2ZkFkenZWWUZwZEUwK3JEamdlWmt2MXNmdUpvRXlTcEFZdVY1cS9y?=
 =?utf-8?B?TWljUXBhS2VLOVVDZXU4VzRMWXlRUWVXODBUWmNuM21LMnFhamNxSTFVYy9x?=
 =?utf-8?B?b0FObTFJdkZheGxTOWpCQVJLNU1jZlFwNVVETjVQam1Ba3M4QmU2S2YzTGZL?=
 =?utf-8?B?d1YrY1dkcEM3aUNWVDZ1OUs4Q0pNYzVBTmpjNkt4cVZWS0pyUGI1MGFSTkR3?=
 =?utf-8?B?bjNjN0dHWWFIZ21WRjVwOWxaejdRNHBMQnZEMThqQTJZMCtaM25DVXh1eWk5?=
 =?utf-8?B?YnFSeStoNzgwTTJSMDNnaXJscHJCUDVrbjQ4cTVLdzFxVDVhSmlBT3MrcnVu?=
 =?utf-8?B?VkZQeW5mUy8rL3MxMnFlSzlrYjh5c0hQRit6eG9yZkpkUTYxUTVWVHVHQzVQ?=
 =?utf-8?B?N2ZZR1FaL1VZUzJxNlV6T2JWTTRuVTJ2WFZlZlJ1L3JSTXJ5TzlkeXo2TTZa?=
 =?utf-8?B?M2dtbzRwWk5taCtGY01EdjA4cHo3eXJWaEtlYUhnd3V2Z1NmeTRZaEFBN2tj?=
 =?utf-8?B?T2tWSnQ4Um80dWJzMzh6SWRJcG5iM25OUzd3L1UrSm5RL1lkdFBtYXhudVMw?=
 =?utf-8?B?KzlvVUlLQVRGYUFtamNPWDU0VitGQTVSdFJnc29LMjlyUFBuSmI0eklKclRC?=
 =?utf-8?B?RTUyYVdlN3U4Mld4REtXcnBNUEFPc2lMblZkN1AzSjVIUm5wWHlUMm0vZFhW?=
 =?utf-8?B?TUpSVkh3SGZ3RlBidTFGTktQenBGN2I2bU9hYytFS1RqTTFCZDZRSU5FUWRq?=
 =?utf-8?B?c1BDYWowZHRsZDBHcDZROENkSzZZZi9YQmhwVlNPZjkrdFBBY0RFbTZMODVr?=
 =?utf-8?B?dUJrMFV4NkVQS3QyYUJZb0JKTURTdVdsd3F2Ynd6ZUlqdEhGa3J0Rkx5bXRF?=
 =?utf-8?B?SndaeDZpZytNZUY2djRCK2t1NHFpdmRoQnBJbmdvN01CWDEvVTVVZDRGMGtB?=
 =?utf-8?B?MUhjZ3RPWUJxVW5sSWtLcU9rUFFqS2xoOWxaanA5ZjNXTE5yRWtabTdmZ2RX?=
 =?utf-8?B?T045d3JrL0xzUWVZV1ZMdEJNYlNQN3lXWEVxTnA0M3NnWlRIamc2K0U4Z1BL?=
 =?utf-8?B?aWtFZ3ZvSFpkaWpTOFJ5N3BweGZwTDhneWlsZUNsQmtHUGt3TjBSZU15emlV?=
 =?utf-8?B?dmVnZzEzbGVUM1dhSVdmMVRDelRobmh0U3hOU0ttSzN2Y0NmaVFBMTY3NUEy?=
 =?utf-8?B?N2Vnd2F3alFaejZpaXhPSHhXd0pQMG1YcDZYVDhFU3o2MWdsaVE2aXZLT2ts?=
 =?utf-8?B?S0RDaTk3eitwVGdhS1A4K0Q5d1FXcmoxNUlFamx3NXBxb3E4Q0RaeDFGb1Fu?=
 =?utf-8?B?Q1luZnVybkE3Nlk2WmFTbE1GWEpjYitEeGlFYjVCV0FJNVg3aVpYZUNHbmxl?=
 =?utf-8?B?SDF3RkdTNGxpTFRheDhTZWk0bjVUcDdDODNremxTWnhnMm1kc2pCTTRLUkRE?=
 =?utf-8?Q?nafoxFLpQtesDoJWKeiQQFzr7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b2a3de-500c-49fa-b648-08dc59a89882
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:53:02.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbpLwiOS75VkEemRgBL4n67cKIWs2NNUA0Ahy/dPln+JOAnDzIJXZ16u4OOQuHZk3+DkmtreLyuU+Ezge4QpOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

On 4/10/2024 2:13 AM, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> The patch mentioned in the `Fixes` tag removed the explicit assignment
> of tx_info->xdpf to NULL with the justification that there's no need
> to set tx_info->xdpf to NULL and tx_info->num_of_bufs to 0 in case
> of a mapping error. Both values won't be used once the mapping function
> returns an error, and their values would be overridden by the next
> transmitted packet.
> 
> While both values do indeed get overridden in the next transmission
> call, the value of tx_info->xdpf is also used to check whether a TX
> descriptor's transmission has been completed (i.e. a completion for it
> was polled).
> 
> An example scenario:
> 1. Mapping failed, tx_info->xdpf wasn't set to NULL
> 2. A VF reset occurred leading to IO resource destruction and
>     a call to ena_free_tx_bufs() function
> 3. Although the descriptor whose mapping failed was freed by the
>     transmission function, it still passes the check
>       if (!tx_info->skb)
> 
>     (skb and xdp_frame are in a union)
> 4. The xdp_frame associated with the descriptor is freed twice
> 
> This patch returns the assignment of NULL to tx_info->xdpf to make the
> cleaning function knows that the descriptor is already freed.
> 
> Fixes: 504fd6a5390c ("net: ena: fix DMA mapping function issues in XDP")
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>


Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   drivers/net/ethernet/amazon/ena/ena_xdp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
> index 337c435d..5b175e7e 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
> @@ -89,7 +89,7 @@ int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
> 
>          rc = ena_xdp_tx_map_frame(tx_ring, tx_info, xdpf, &ena_tx_ctx);
>          if (unlikely(rc))
> -               return rc;
> +               goto err;
> 
>          ena_tx_ctx.req_id = req_id;
> 
> @@ -112,7 +112,9 @@ int ena_xdp_xmit_frame(struct ena_ring *tx_ring,
> 
>   error_unmap_dma:
>          ena_unmap_tx_buff(tx_ring, tx_info);
> +err:
>          tx_info->xdpf = NULL;
> +
>          return rc;
>   }
> 
> --
> 2.40.1
> 
> 

